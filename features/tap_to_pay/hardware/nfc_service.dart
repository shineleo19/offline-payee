// lib/features/tap_to_pay/hardware/nfc_service.dart

import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
// FIXED 1: The new Android-specific import path for version 4.x
import 'package:nfc_manager/nfc_manager_android.dart';

class NfcService {
  static const String OFFLINE_PAY_AID = "F2222222222200";
  static const int SELECT_COMMAND = 0xA4;
  static const int CLA_ISO = 0x00;

  Future<void> startMerchantReader({
    required Function(Uint8List payload) onPayloadReceived,
    required Function(String error) onError,
  }) async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      onError('NFC is disabled or not supported on this device.');
      return;
    }

    await NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        // FIXED 2: IsoDep was renamed to IsoDepAndroid
        final isoDep = IsoDepAndroid.from(tag);

        if (isoDep == null) {
          onError('Tag does not support ISO-DEP communication.');
          NfcManager.instance.stopSession();
          return;
        }

        try {
          // 1. Construct the SELECT AID command
          final aidBytes = _hexToBytes(OFFLINE_PAY_AID);
          final selectApdu = Uint8List.fromList([
            CLA_ISO, SELECT_COMMAND, 0x04, 0x00, aidBytes.length, ...aidBytes
          ]);

          // 2. Transmit command and wait for Customer's CBOR payload response
          final response = await isoDep.transceive(selectApdu);

          // Check if the response ends with the success Status Word (0x90 0x00)
          if (response.length >= 2 &&
              response[response.length - 2] == 0x90 &&
              response[response.length - 1] == 0x00) {

            // Extract the actual payload, stripping the status bytes
            final payload = response.sublist(0, response.length - 2);
            onPayloadReceived(payload);
          } else {
            onError('Incomplete payload or tap dropped.');
          }
        } catch (e) {
          onError('NFC transmission failed: $e');
        } finally {
          NfcManager.instance.stopSession();
        }
      },
    );
  }

  Uint8List _hexToBytes(String hexStr) {
    final bytes = <int>[];
    for (int i = 0; i < hexStr.length; i += 2) {
      bytes.add(int.parse(hexStr.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(bytes);
  }
}