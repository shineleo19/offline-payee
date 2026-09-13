// lib/features/wallet/bloc/wallet_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/wallet_repository.dart';
import '../../../core/database/database_schema.dart';

// --- Events ---
abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object> get props => [];
}

class LoadWalletData extends WalletEvent {}

// --- States ---
abstract class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object?> get props => [];
}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet wallet;
  final double displayBalance;

  const WalletLoaded({required this.wallet, required this.displayBalance});

  @override
  List<Object?> get props => [wallet, displayBalance];
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);
  @override
  List<Object?> get props => [message];
}

// --- Bloc ---
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _repository;

  WalletBloc({required WalletRepository repository})
      : _repository = repository,
        super(WalletLoading()) {

    on<LoadWalletData>((event, emit) async {
      // 1. We use emit.forEach to automatically listen to Drift's live stream!
      await emit.forEach<Wallet?>(
        _repository.watchPrimaryWallet(),
        onData: (wallet) {
          if (wallet != null) {
            // Convert minor units (paise) back to major units (Rupees)
            final balance = wallet.offlineBalance / 100;
            return WalletLoaded(wallet: wallet, displayBalance: balance);
          } else {
            return const WalletError("No wallet found. Database not seeded.");
          }
        },
        onError: (error, stackTrace) => WalletError(error.toString()),
      );
    });
  }
}