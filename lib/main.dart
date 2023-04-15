import 'dart:async';
import 'package:flutter_tests/battle.dart';
import 'package:flutter_tests/services/globals.dart';
import 'components/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ref.read(timeNotifierProvider.notifier).incrementTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(timeNotifierProvider);
    final inBattle = ref.watch(inBattleProvider);

    // ignore: unused_local_variable
    late Timer respawn; // it is used in the onProgressComplete callback.

    return Scaffold(
      appBar: AppBar(title: TimerComponent(timerInfo: time)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () =>
                    ref.read(inBattleProvider.notifier).state = !inBattle,
                child: const Text("Toggle Battle")),
            const SizedBox(width: 10),
            BattleComponent(),
          ],
        ),
      ),
    );
  }
}
