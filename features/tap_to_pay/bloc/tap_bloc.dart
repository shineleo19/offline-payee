// lib/features/tap_to_pay/bloc/tap_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cryptography/cryptography.dart';
import 'dart:typed_data';
import 'tap_state.dart';
import 'tap_event.dart';

// 1. Absolute import for the hardware bridge
import 'package:offlinepay/features/tap_to_pay/hardware/hce_bridge.dart';

// 2. Absolute import for the cryptography and payload models
// Ensure both OfflineProtocol AND TransactionPayload classes are saved inside this file!
import 'package:offlinepay/core/protocol/offline_protocol.dart';
// Note: Ensure your TransactionPayload is imported from here or within offline_protocol.dart
// import '../../../core/protocol/transaction_payload.dart';


// --- Bloc ---

/// Manages the Two-Phase Commit lifecycle of a physical NFC tap.
class TapBloc extends Bloc<TapEvent, TapState> {
  // Inject the hardware bridge and crypto protocol
  final HceBridge _hceBridge = HceBridge();
  final OfflineProtocol _protocol = OfflineProtocol();

  TapBloc() : super(const TapIdle()) {
    on<TapInitiated>(_onTapInitiated);
    on<CustomerPaymentAuthorized>(_onCustomerPaymentAuthorized); // NEW ROUTE
    on<PhaseOneCompleted>(_onPhaseOneCompleted);
    on<HardwareConnectionDropped>(_onHardwareConnectionDropped);
    on<ValidReceiptReceived>(_onValidReceiptReceived);
  }

  void _onTapInitiated(TapInitiated event, Emitter<TapState> emit) {
    if (state is TapIdle || state is TransferAborted || state is OfflineAccepted) {
      emit(const ExchangingPayload());
    }
  }

  /// NEW: Handles the cryptographic signing and pushes bytes to the Kotlin NFC layer
  Future<void> _onCustomerPaymentAuthorized(
      CustomerPaymentAuthorized event,
      Emitter<TapState> emit
      ) async {
    // Transition UI to show the "Ready to Tap" or "Exchanging" state
    emit(const ExchangingPayload());

    try {
      // 1. Create the strictly typed payload
      final payload = TransactionPayload(
        merchantId: event.targetMerchantId,
        amount: event.amountMinor,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        counter: event.walletCounter,
      );

      // 2. Sign it and convert to CBOR
      final signature = await _protocol.signTransaction(
        payload: payload,
        privateKey: event.customerPrivateKey,
      );

      // Combine CBOR bytes and signature bytes for transport
      final cborBytes = payload.toCborBytes();
      final fullNfcPayload = Uint8List.fromList([...cborBytes, ...signature.bytes]);

      // 3. Push it down to native memory via MethodChannel
      await _hceBridge.stagePayloadForTap(fullNfcPayload);

    } catch (e) {
      emit(TransferAborted(reason: 'Failed to construct and stage payload: $e'));
    }
  }

  void _onPhaseOneCompleted(PhaseOneCompleted event, Emitter<TapState> emit) {
    if (state is ExchangingPayload) {
      emit(IncompletePendingProbe(transactionId: event.transactionId));
    }
  }

  void _onHardwareConnectionDropped(HardwareConnectionDropped event, Emitter<TapState> emit) {
    if (state is ExchangingPayload) {
      emit(const TransferAborted(reason: 'NFC connection lost during payload exchange.'));
    } else if (state is IncompletePendingProbe) {
      // Intentional empty block: Must remain here until a background probe resolves the status
    }
  }

  void _onValidReceiptReceived(ValidReceiptReceived event, Emitter<TapState> emit) {
    if (state is IncompletePendingProbe) {
      emit(OfflineAccepted(receiptId: event.receiptId));
    }
  }
}