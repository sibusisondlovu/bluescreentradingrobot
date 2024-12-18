import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check, color: Colors.green),
      title: Text(text, style: const TextStyle(fontSize: 13),),
    );
  }
}