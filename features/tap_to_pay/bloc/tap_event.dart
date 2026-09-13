// lib/features/tap_to_pay/bloc/tap_event.dart
import 'package:equatable/equatable.dart';
import 'package:cryptography/cryptography.dart';

abstract class TapEvent extends Equatable {
  const TapEvent();
  @override
  List<Object?> get props => [];
}

class TapInitiated extends TapEvent {
  const TapInitiated();
}

class CustomerPaymentAuthorized extends TapEvent {
  final String targetMerchantId;
  final int amountMinor;
  final int walletCounter;
  final SimpleKeyPair customerPrivateKey;

  const CustomerPaymentAuthorized({
    required this.targetMerchantId,
    required this.amountMinor,
    required this.walletCounter,
    required this.customerPrivateKey,
  });

  @override
  List<Object?> get props => [targetMerchantId, amountMinor, walletCounter];
}

class PhaseOneCompleted extends TapEvent {
  final String transactionId;
  const PhaseOneCompleted({required this.transactionId});
  @override
  List<Object?> get props => [transactionId];
}

class HardwareConnectionDropped extends TapEvent {
  const HardwareConnectionDropped();
}

class ValidReceiptReceived extends TapEvent {
  final String receiptId;
  const ValidReceiptReceived({required this.receiptId});
  @override
  List<Object?> get props => [receiptId];
}