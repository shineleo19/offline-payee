// lib/features/sync_ledger/bloc/sync_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/sync_repository.dart';

// --- States ---
abstract class SyncState extends Equatable {
  const SyncState();
  @override
  List<Object> get props => [];
}

class SyncIdle extends SyncState {}

class SyncInProgress extends SyncState {}

class SyncSuccess extends SyncState {
  final int count;
  const SyncSuccess(this.count);
  @override
  List<Object> get props => [count];
}

class SyncFailure extends SyncState {
  final String error;
  const SyncFailure(this.error);
  @override
  List<Object> get props => [error];
}

// --- Cubit ---
class SyncCubit extends Cubit<SyncState> {
  final SyncRepository _repository;

  SyncCubit({required SyncRepository repository})
      : _repository = repository,
        super(SyncIdle());

  Future<void> runCloudSync() async {
    emit(SyncInProgress());
    try {
      final syncedCount = await _repository.syncPendingLedger();
      emit(SyncSuccess(syncedCount));

      // Reset back to idle after a few seconds so the button is ready again
      await Future.delayed(const Duration(seconds: 2));
      emit(SyncIdle());
    } catch (e) {
      emit(SyncFailure(e.toString()));
      emit(SyncIdle());
    }
  }
}