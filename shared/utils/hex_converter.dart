// lib/shared/utils/hex_converter.dart
import 'dart:typed_data';
import 'package:convert/convert.dart';

class HexConverter {
  static String toHex(Uint8List bytes) {
    return hex.encode(bytes);
  }

  static Uint8List fromHex(String hexString) {
    return Uint8List.fromList(hex.decode(hexString));
  }
}