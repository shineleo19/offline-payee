// lib/main.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'features/wallet/repository/wallet_repository.dart';
import 'features/wallet/bloc/wallet_bloc.dart';
import 'features/sync_ledger/repository/sync_repository.dart';
import 'features/sync_ledger/bloc/sync_cubit.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:app_settings/app_settings.dart';

// Import your features and database
import 'features/tap_to_pay/bloc/tap_bloc.dart';
import 'features/tap_to_pay/presentation/customer_tap_screen.dart';
import 'features/tap_to_pay/presentation/merchant_receive_screen.dart';
import 'core/database/database_schema.dart';

void main() async {
  // Required so we can use path_provider before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the native SQLite database
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'offline_wallet.sqlite'));
  final database = AppDatabase(NativeDatabase.createInBackground(file));

  runApp(OfflinePayApp(database: database));
}

class OfflinePayApp extends StatelessWidget {
  final AppDatabase database;

  const OfflinePayApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfflinePay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Deep Slate
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF14B8A6), // Neon Teal
          secondary: Color(0xFF10B981), // Emerald
          surface: Color(0xFF1E293B), // Elevated Surface
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      // Set the home to our new dual-mode switcher
      home: HomeScreen(database: database),
    );
  }
}

// -------------------------------------------------------------
// The Dual-Mode Switcher Code
// -------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  final AppDatabase database;
  const HomeScreen({Key? key, required this.database}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability(); // Run hardware safety check on startup
  }

  Future<void> _checkNfcAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    while (!isAvailable && mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('Enable NFC to Continue', style: TextStyle(color: Colors.white)),
          content: const Text(
            'OfflinePay requires NFC. Please tap below to open Settings, navigate to Connected Devices or Connections, and turn on the NFC switch.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF14B8A6)),
              onPressed: () async {
                try {
                  await AppSettings.openAppSettings(type: AppSettingsType.wireless);
                } catch (_) {
                  await AppSettings.openAppSettings();
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Open Settings', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );

      isAvailable = await NfcManager.instance.isAvailable();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TapBloc(),
          ),
          BlocProvider(
            create: (context) => WalletBloc(
              repository: WalletRepository(widget.database),
            )..add(LoadWalletData()),
          ),
        ],
        child: const CustomerTapScreen(),
      ),
      BlocProvider(
        create: (context) => SyncCubit(repository: SyncRepository(widget.database)),
        child: MerchantReceiveScreen(database: widget.database),
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Customer'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.point_of_sale),
              label: 'Merchant POS'
          ),
        ],
      ),
    );
  }
}