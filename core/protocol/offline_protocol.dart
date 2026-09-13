// lib/core/protocol/offline_protocol.dart

import 'dart:typed_data';
import 'package:cbor/cbor.dart';
import 'package:cryptography/cryptography.dart';

class TransactionPayload {
  final String merchantId;
  final int amount;
  final int timestamp;
  final int counter;

  const TransactionPayload({
    required this.merchantId,
    required this.amount,
    required this.timestamp,
    required this.counter,
  });

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