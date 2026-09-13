import 'dart:typed_data';
import 'package:cbor/cbor.dart';
import 'package:cryptography/cryptography.dart';

class TransactionPayload {
  final String merchantId;
  final int amount; // Minor units (e.g., paise)
  final int timestamp;
  final int counter;

  const TransactionPayload({
    required this.merchantId,
    required this.amount,
    required this.timestamp,
    required this.counter,
  });

  /// Deterministic CBOR using small integer keys for maximum NFC compression:
  /// 2 = merchantId, 5 = amount, 7 = counter, 9 = timestamp
  List<int> toCborBytes() {
    final cborMap = CborMap({
      CborSmallInt(2): CborString(merchantId),
      CborSmallInt(5): CborInt(BigInt.from(amount)),
      CborSmallInt(7): CborInt(BigInt.from(counter)),
      CborSmallInt(9): CborInt(BigInt.from(timestamp)),
    });

    return cbor.encode(cborMap);
  }
}

class OfflineProtocol {
  final Ed25519 _ed25519 = Ed25519();

  Future<Signature> signTransaction({
    required TransactionPayload payload,
    required SimpleKeyPair privateKey,
  }) async {
    final cborBytes = payload.toCborBytes();
    return await _ed25519.sign(cborBytes, keyPair: privateKey);
  }

  /// Fixed: Explicitly attaches the expected merchant public key to the verification check
  Future<bool> verifyMerchantReceipt({
    required List<int> receiptCborBytes,
    required List<int> signatureBytes,
    required PublicKey merchantPublicKey,
  }) async {
    final signature = Signature(
      signatureBytes,
      publicKey: merchantPublicKey,
    );

    return await _ed25519.verify(
      receiptCborBytes,
      signature: signature,
    );
  }
}