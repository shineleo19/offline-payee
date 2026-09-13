// lib/features/tap_to_pay/presentation/customer_tap_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptography/cryptography.dart';
import '../bloc/tap_bloc.dart';
import 'package:local_auth/local_auth.dart';
import '../../wallet/bloc/wallet_bloc.dart';
import '../bloc/tap_state.dart';
import '../bloc/tap_event.dart';
import '../../../shared/widgets/nfc_animation.dart';

// CHANGED: Converted to StatefulWidget to manage the TextField controller
class CustomerTapScreen extends StatefulWidget {
  const CustomerTapScreen({Key? key}) : super(key: key);

  @override
  State<CustomerTapScreen> createState() => _CustomerTapScreenState();
}

class _CustomerTapScreenState extends State<CustomerTapScreen> {
  // NEW: The controller that captures the amount typed by the user
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Wallet'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colorScheme.primary.withOpacity(0.2),
            height: 1.0,
          ),
        ),
      ),
      body: BlocBuilder<TapBloc, TapState>(
        builder: (context, state) {
          final isStaged = state is ExchangingPayload;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.2),
                radius: 1.2,
                colors: [
                  colorScheme.surface,
                  const Color(0xFF0F172A),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -----------------------------------------
                // TOP: Premium Digital Wallet Card (DYNAMIC)
                // -----------------------------------------
                BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, walletState) {
                      String balanceText = '₹ --.--';
                      String walletIdText = 'Loading...';

                      if (walletState is WalletLoaded) {
                        balanceText = '₹${walletState.displayBalance.toStringAsFixed(2)}';
                        walletIdText = 'Wallet #${walletState.wallet.id} • Ready to Pay';
                      }

                      return Container(
                        width: 320,
                        height: 200,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.surface.withOpacity(0.9),
                              colorScheme.surface.withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.account_balance_wallet, color: Colors.white70, size: 30),
                                Icon(Icons.wifi_off, color: colorScheme.primary, size: 24),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('AVAILABLE OFFLINE BALANCE', style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.5)),
                                const SizedBox(height: 4),
                                Text(balanceText, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(walletIdText, style: TextStyle(color: colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      );
                    }
                ),

                const SizedBox(height: 60),

                // -----------------------------------------
                // BOTTOM: Dynamic Action Area
                // -----------------------------------------
                if (!isStaged) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixText: '₹ ',
                        prefixStyle: TextStyle(color: colorScheme.primary, fontSize: 28, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: colorScheme.surface,
                        hintText: '0.00',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: colorScheme.primary, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _authorizeAndStage(context);
                    },
                    icon: const Icon(Icons.fingerprint, size: 28),
                    label: const Text('Authorize Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                      shadowColor: colorScheme.primary.withOpacity(0.5),
                    ),
                  ),
                ] else ...[
                  // State 2: Ready to Tap using the modular shared widget
                  const NfcPulseAnimation(),
                  const SizedBox(height: 32),
                  const Text(
                    'Ready to Tap.\nHold near merchant phone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, height: 1.4),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusIcon(TapState state) {
    if (state is ExchangingPayload) {
      return const Icon(Icons.contactless, size: 120, color: Colors.blueAccent);
    } else if (state is IncompletePendingProbe) {
      return const Icon(Icons.sync, size: 120, color: Colors.orange);
    } else if (state is OfflineAccepted) {
      return const Icon(Icons.check_circle, size: 120, color: Colors.green);
    }
    return const Icon(Icons.account_balance_wallet, size: 120, color: Colors.grey);
  }

  Widget _buildStatusText(TapState state) {
    if (state is ExchangingPayload) {
      return const Text('Ready to Tap. Hold near merchant phone.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    } else if (state is IncompletePendingProbe) {
      return const Text('Verifying receipt...',
          style: TextStyle(fontSize: 18, color: Colors.orange));
    } else if (state is OfflineAccepted) {
      return const Text('Payment Complete',
          style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold));
    }
    return const Text('Tap button to authorize payment', style: TextStyle(fontSize: 16));
  }

  Future<void> _authorizeAndStage(BuildContext context) async {
    // 1. Read the typed amount and convert to minor units
    final amountDouble = double.tryParse(_amountController.text) ?? 0.0;
    final int amountMinor = (amountDouble * 100).toInt();

    if (amountMinor <= 0) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter a valid amount.', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red
          ),
        );
      }
      return;
    }

    // Used strictly for the UI Biometric Prompt display
    final displayAmount = amountDouble.toStringAsFixed(2);

    final LocalAuthentication auth = LocalAuthentication();

    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No biometric security set up on this device.', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
          );
        }
        return;
      }

      // 2. DYNAMIC PROMPT: Tells the user exactly what they are authorizing!
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Scan fingerprint to authorize ₹$displayAmount offline transfer',
      );

      if (!didAuthenticate) {
        return;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication error: $e')),
        );
      }
      return;
    }

    final ed25519 = Ed25519();
    final mockKeyPair = await ed25519.newKeyPair();

    if (!context.mounted) return;

    // 3. Push the dynamic amount to the hardware
    context.read<TapBloc>().add(
      CustomerPaymentAuthorized(
        targetMerchantId: 'merchant_tea_001',
        amountMinor: amountMinor, // Sends the typed amount instead of 5000!
        walletCounter: 1,
        customerPrivateKey: mockKeyPair,
      ),
    );
  }
}