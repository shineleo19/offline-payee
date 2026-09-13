// lib/features/tap_to_pay/bloc/tap_state.dart
import 'package:equatable/equatable.dart';

abstract class TapState extends Equatable {
  const TapState();
  @override
  List<Object?> get props => [];
}

class TapIdle extends TapState {
  const TapIdle();
}

class ExchangingPayload extends TapState {
  const ExchangingPayload();
}

class IncompletePendingProbe extends TapState {
  final String transactionId;
  const IncompletePendingProbe({required this.transactionId});
  @override
  List<Object?> get props => [transactionId];
}

class OfflineAccepted extends TapState {
  final String receiptId;
  const OfflineAccepted({required this.receiptId});
  @override
  List<Object?> get props => [receiptId];
}

class TransferAborted extends TapState {
  final String reason;
  const TransferAborted({required this.reason});
  @override
  List<Object?> get props => [reason];
}