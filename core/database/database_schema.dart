import 'package:drift/drift.dart';
import 'dart:typed_data';

// FIXED: Exact lowercase filename required by the builder
part 'database_schema.g.dart';

class Wallets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get walletAddress => text().unique()();
  IntColumn get offlineBalance => integer()();
  IntColumn get monotonicCounter => integer().withDefault(const Constant(0))();
}

class PendingLedger extends Table {
  IntColumn get id => integer().autoIncrement()();

  // FIXED: Removed the `.references()` modifier to bypass the drift_dev parser bug.
  // We enforce the relational integrity inside the transaction logic below.
  IntColumn get walletId => integer()();

  TextColumn get transactionId => text().unique()();
  BlobColumn get cborPayload => blob()();
  BlobColumn get signature => blob()();
  BlobColumn get encryptedJournal => blob()();

  // FIXED: Safely default the timestamp at the Dart level instead of the SQLite expression level
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}

@DriftDatabase(tables: [Wallets, PendingLedger])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      // Seed initial customer wallet if empty
      final count = await select(wallets).get();
      if (count.isEmpty) {
        await into(wallets).insert(
          WalletsCompanion.insert(
            walletAddress: '0xCUSTOMER_DEMO_01',
            offlineBalance: 100000, // ₹1,000.00 reserve
            monotonicCounter: const Value(0),
          ),
        );
      }
    },
  );

  /// Executes an atomic commit to update the wallet state and append to the ledger.
  Future<void> commitOfflineTransaction({
    required int walletId,
    required int deductionAmount,
    required String transactionId,
    required Uint8List cborPayload,
    required Uint8List signature,
    required Uint8List encryptedJournal,
  }) async {
    await transaction(() async {
      // 1. Fetch current wallet state
      final wallet = await (select(wallets)..where((w) => w.id.equals(walletId))).getSingle();

      if (wallet.offlineBalance < deductionAmount) {
        throw Exception('Insufficient offline balance.');
      }

      // 2. Update Wallet (Deduct balance, increment monotonic counter)
      await (update(wallets)..where((w) => w.id.equals(walletId))).write(
        WalletsCompanion(
          offlineBalance: Value(wallet.offlineBalance - deductionAmount),
          monotonicCounter: Value(wallet.monotonicCounter + 1),
        ),
      );

      // 3. Insert into Pending Ledger
      await into(pendingLedger).insert(
        PendingLedgerCompanion.insert(
          walletId: walletId,
          transactionId: transactionId,
          cborPayload: cborPayload,
          signature: signature,
          encryptedJournal: encryptedJournal,
        ),
      );
    });
  }
}