// lib/features/sync_ledger/repository/sync_repository.dart

import 'package:convert/convert.dart';
import '../../../core/database/database_schema.dart';
import '../../../core/network/api_client.dart'; // Import the new client

class SyncRepository {
  final AppDatabase _database;
  final ApiClient _apiClient = ApiClient(); // Instantiate the clean wrapper

  SyncRepository(this._database);

  Future<int> syncPendingLedger() async {
    final pendingRecords = await _database.select(_database.pendingLedger).get();
    if (pendingRecords.isEmpty) return 0;

    int successCount = 0;

    for (final record in pendingRecords) {
      try {
        final payload = {
          "transactionId": record.transactionId,
          "walletId": record.walletId,
          "cborPayloadHex": hex.encode(record.cborPayload),
          "signatureHex": hex.encode(record.signature),
          "customerPublicKeyHex": "f1e2d3c4b5a6",
        };

        // Uses the centralized interceptor/client wrapper
        await _apiClient.post('/api/sync', payload);

        // If no exception was thrown, delete the local record
        await (_database.delete(_database.pendingLedger)
          ..where((t) => t.id.equals(record.id))).go();
        successCount++;

      } catch (e) {
        print('Sync interrupted: $e');
        break; // Stop loop on network failure to preserve state order
      }
    }
    return successCount;
  }
}