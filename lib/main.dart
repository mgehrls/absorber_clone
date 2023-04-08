// ignore_for_file: library_private_types_in_public_api

import 'package:absorber_clone/utils/looping_bar.dart';
import 'package:decimal/decimal.dart';
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
  late TurnIndicator playerTimer;
  late TurnIndicator enemyTimer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      regen();
      setState(() {
        timePlayed++;
      });
    });
  }

  void regen() {
    if (!inBattle) {
      if (player.hp < player.maxHp) {
        player.hp = player.hp + 1.toDecimal() > player.maxHp
            ? player.maxHp
            : player.hp + 1.toDecimal();
      }
    }
  }

  void startBattle() {
    inBattle = true;
    activeFight = true;
  }

  void firstAttacksSecond(Fighter first, Fighter second) {
    second.hp = second.hp - first.attack;
    if (second.hp <= 0.toDecimal()) {
      second.hp = 0.toDecimal();
      if (second is Enemy && first is Player) {
        second.killed += 1;
        first.absorbStat('speed', -1);
        first.absorbStat('attack', .02);
        first.absorbStat('maxHp', .01);
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
    delayedFunction(() {
      enemyRespawn();
      if (inBattle) {
        activeFight = true;
      }
    });
  }

  void enemyRespawn() {
    enemy.hp = enemy.maxHp;
  }

  void endBattle() {
    inBattle = false;
    activeFight = false;
    enemyRespawn();
  }

  Future<void> delayedFunction(Function x) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    x();
  }

  @override
  void initState() {
    super.initState();
    enemy = Bat(2.toDecimal(), 0);
    player = Player(2500, 1.toDecimal(), 10.toDecimal(), 10.toDecimal());
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(timePlayed.toString())),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TurnIndicator(
                  duration: enemy.speed,
                  onProgressComplete: () => firstAttacksSecond(enemy, player),
                  isPlaying: activeFight,
                ),
                const SizedBox(height: 20),
                Text('${enemy.name} Health: ${enemy.hp}'),
                Text('${enemy.name}s Killed: ${enemy.killed}'),
                Text('${enemy.name} Population: ${enemy.population}'),
                const SizedBox(height: 20),
                inBattle
                    ? ElevatedButton(
                        onPressed: endBattle,
                        child: const Text('Flee!'),
                      )
                    : ElevatedButton(
                        onPressed: enemy.killed == enemy.population
                            ? null
                            : startBattle,
                        child: const Text('Start Battle'),
                      ),
                const SizedBox(height: 20),
                Text('Player attack: ${player.attack}'),
                Text('Player speed: ${player.speed}'),
                const SizedBox(height: 20),
                TurnIndicator(
                  duration: player.speed,
                  onProgressComplete: () => firstAttacksSecond(player, enemy),
                  isPlaying: activeFight,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HpProgressBar(maxHp: player.maxHp, hp: player.hp),
              Text('Player Health: ${player.hp}/ ${player.maxHp}')
            ],
          ),
        ],
      ),
    );
  }
}
