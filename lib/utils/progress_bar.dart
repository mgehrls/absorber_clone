// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class HpProgressBar extends StatefulWidget {
  final Decimal maxHp;
  final Decimal hp;

  const HpProgressBar({super.key, required this.maxHp, required this.hp});

  @override
  _HpProgressBarState createState() => _HpProgressBarState();
}

class _HpProgressBarState extends State<HpProgressBar> {
  double _percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _calculatePercentage();
  }

  @override
  void didUpdateWidget(covariant HpProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculatePercentage();
  }

  void _calculatePercentage() {
    setState(() {
      _percentage = widget.hp.toDouble() / widget.maxHp.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: LinearProgressIndicator(
        value: _percentage,
        minHeight: 20,
        backgroundColor: Colors.grey[300],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}
