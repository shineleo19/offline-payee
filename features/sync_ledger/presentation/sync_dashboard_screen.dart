// lib/features/sync_ledger/presentation/sync_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sync_cubit.dart';

class SyncDashboardScreen extends StatelessWidget {
  const SyncDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cloud Sync Dashboard')),
      body: Center(
        child: BlocBuilder<SyncCubit, SyncState>(
          builder: (context, state) {
            bool isSyncing = state is SyncInProgress;
            return ElevatedButton.icon(
              onPressed: isSyncing ? null : () => context.read<SyncCubit>().runCloudSync(),
              icon: const Icon(Icons.cloud_sync),
              label: Text(isSyncing ? 'Syncing with Server...' : 'Trigger Manual Sync'),
            );
          },
        ),
      ),
    );
  }
}