// lib/features/wallet/repository/wallet_repository.dart

import '../../../core/database/database_schema.dart';

class WalletRepository {
  final AppDatabase _database;

  WalletRepository(this._database);

  /// Fetches the primary wallet (Wallet #1)
  Future<Wallet?> getPrimaryWallet() async {
    final wallets = await _database.select(_database.wallets).get();
    if (wallets.isNotEmpty) {
      return wallets.first; // Return the first seeded wallet
    }
    return null;
  }

  /// Watch the wallet balance in real-time
  Stream<Wallet?> watchPrimaryWallet() {
    return _database.select(_database.wallets).watchSingleOrNull();
  }
}