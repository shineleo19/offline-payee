// lib/shared/widgets/nfc_animation.dart
import 'package:flutter/material.dart';

class NfcPulseAnimation extends StatelessWidget {
  final Color color;
  const NfcPulseAnimation({Key? key, this.color = Colors.teal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 15,
          ),
        ],
      ),
      child: Icon(Icons.wifi_tethering, size: 80, color: color),
    );
  }
}