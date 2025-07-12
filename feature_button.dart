import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FeatureButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
