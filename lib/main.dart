// ignore_for_file: library_private_types_in_public_api

import 'package:absorber_clone/utils/looping_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'models/fighter.dart';
import 'models/player.dart';
import 'models/enemies.dart';
import 'utils/progress_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Idle RPG',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int timePlayed = 0;
  bool inBattle = false;
  bool activeFight = false;
  late Player player;
  late Enemy enemy;
  late LoopingProgressBar playerTimer;
  late LoopingProgressBar enemyTimer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!inBattle) {
        if (!activeFight) {
        } else {
          regen();
        }
      }
      setState(() {
        timePlayed++;
      });
    });
  }

  void regen() {
    if (!inBattle) {
      if (player.hp < player.maxHp) {
        player.hp =
            double.parse((player.hp + 1).toStringAsFixed(2)) > player.maxHp
                ? player.maxHp
                : double.parse((player.hp + 1).toStringAsFixed(2));
      }
    }
  }

  void startBattle() {
    inBattle = true;
    activeFight = true;
  }

  void firstAttacksSecond(Fighter first, Fighter second) {
    second.hp = double.parse((second.hp - first.attack).toStringAsFixed(2));
    if (second.hp <= 0) {
      second.hp = 0;
      if (second is Enemy) {
        second.killed += 1;
        if (second.killed < second.population) {
          endEncounter();
        } else if (second.killed == second.population) {
          endBattle();
        }
      } else {
        endBattle();
      }
    }
  }

  void endEncounter() async {
    activeFight = false;
    delayedFunction(enemyRespawn);
    delayedFunction(startBattle);
  }

  void enemyRespawn() {
    enemy.hp = enemy.maxHp;
  }

  void endBattle() {
    inBattle = false;
  }

  Future<void> delayedFunction(Function x) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    x();
  }

  @override
  void initState() {
    super.initState();
    enemy = Bat(2, 0);
    player = Player(2500, 1, 10, 10);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(timePlayed.toString())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HpProgressBar(maxHp: player.maxHp, hp: player.hp),
            inBattle
                ? LoopingProgressBar(
                    duration: player.speed,
                    onProgressComplete: () => firstAttacksSecond(player, enemy),
                    isPlaying: activeFight,
                  )
                : const Text("Resting..."),
            Text('Player Health: ${player.hp}'),
            Text('${enemy.name} Health: ${enemy.hp}'),
            const SizedBox(height: 20),
            inBattle
                ? ElevatedButton(
                    onPressed: endBattle,
                    child: const Text('Flee!'),
                  )
                : ElevatedButton(
                    onPressed:
                        enemy.killed == enemy.population ? null : startBattle,
                    child: const Text('Start Battle'),
                  ),
            const SizedBox(height: 20),
            inBattle
                ? LoopingProgressBar(
                    duration: enemy.speed,
                    onProgressComplete: () => firstAttacksSecond(enemy, player),
                    isPlaying: activeFight,
                  )
                : const Text("Awaiting your challenge"),
            Text('${enemy.name}s Killed: ${enemy.killed}'),
            Text('${enemy.name} Population: ${enemy.population}'),
          ],
        ),
      ),
    );
  }
}
