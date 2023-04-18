import 'dart:async';
import 'package:absorber_clone/services/enemies.dart';
import 'package:absorber_clone/services/enemy.dart';
import 'package:absorber_clone/services/player.dart';
import 'package:decimal/decimal.dart';

import 'components/battle.dart';
import 'components/stat_page.dart';
import 'services/globals.dart';
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
      if (!ref.read(inBattleProvider)) {
        ref.read(playerNotifierProvider.notifier).regenHp(Decimal.one);
      }
      if (ref.watch(autoBattleProvider) &&
          !ref.watch(inBattleProvider) &&
          ref.read(playerNotifierProvider).hp.isFull()) {
        ref
            .read(enemyNotifierProvider.notifier)
            .newEnemy(ref.read(enemyListProvider.notifier).getNewEnemy());
        ref.read(inBattleProvider.notifier).state = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(timeNotifierProvider);
    final inBattle = ref.watch(inBattleProvider);
    final autoBattle = ref.watch(autoBattleProvider);

    // ignore: unused_local_variable
    late Timer respawn; // it is used in the onProgressComplete callback.

    return Scaffold(
      appBar: AppBar(title: TimerComponent(timerInfo: time)),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(autoBattleProvider.notifier).state = !autoBattle;
                    },
                    child: autoBattle
                        ? const Text("AutoBattle: On")
                        : const Text("AutoBattle: Off"))
              ],
            ),
            ElevatedButton(
                onPressed: () =>
                    ref.read(inBattleProvider.notifier).state = !inBattle,
                child: inBattle
                    ? const Text("Stop Battle")
                    : const Text("Start Battle")),
            const SizedBox(width: 10),
            const BattleComponent(),
            const SizedBox(height: 40),
            const StatPage(),
          ],
        ),
      ),
    );
  }
}
