import 'package:flutter/services.dart';
import 'dart:typed_data';

class HceBridge {
  static const platform = MethodChannel('com.example.offlinepay/nfc');

  /// Stages the signed transaction in native memory.
  /// Call this the moment the user authorizes the payment with biometrics,
  /// right before they tap the merchant's phone.
  Future<void> stagePayloadForTap(Uint8List signedCborPayload) async {
    try {
      await platform.invokeMethod('stagePayload', {
        'payload': signedCborPayload,
      });
      print('Payload successfully staged in Kotlin for HCE.');
    } on PlatformException catch (e) {
      print('Failed to stage payload: ${e.message}');
    }
  }
}