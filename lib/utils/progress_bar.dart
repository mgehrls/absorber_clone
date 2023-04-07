// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class HpProgressBar extends StatefulWidget {
  final double maxHp;
  final double hp;

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
      _percentage = widget.hp / widget.maxHp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _percentage,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }
}

class TurnIndicator extends StatefulWidget {
  final int turnLength;

  const TurnIndicator({Key? key, required this.turnLength}) : super(key: key);

  @override
  _TurnIndicatorState createState() => _TurnIndicatorState();

  void startTimer() {
    _TurnIndicatorState state = _TurnIndicatorState();
    state._startTimer();
  }

  void stopTimer() {
    _TurnIndicatorState state = _TurnIndicatorState();
    state._stopTimer();
  }
}

class _TurnIndicatorState extends State<TurnIndicator> {
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: widget.turnLength), (timer) {
      setState(() {
        _progress = 1;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progress,
      backgroundColor: Colors.grey[300],
      minHeight: 10,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
