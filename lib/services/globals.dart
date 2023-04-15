import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

final inBattleProvider = StateProvider<bool>((ref) => false);

class TimeNotifier extends StateNotifier<int> {
  TimeNotifier() : super(0);

  void incrementTime() {
    state++;
  }

  final int totalPlayTime = 0;
}

final timeNotifierProvider = StateNotifierProvider<TimeNotifier, int>(
  (ref) => TimeNotifier(),
);
