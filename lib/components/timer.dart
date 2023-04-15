import 'package:flutter/material.dart';

class TimerComponent extends StatelessWidget {
  final int timerInfo;
  const TimerComponent({super.key, required this.timerInfo});

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text(printDuration(Duration(seconds: timerInfo)));
  }
}
