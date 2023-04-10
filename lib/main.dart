// ignore_for_file: library_private_types_in_public_api

import 'package:absorber_clone/models/attack.dart';
import 'package:absorber_clone/models/hp.dart';
import 'package:absorber_clone/models/speed.dart';
import 'package:absorber_clone/utils/turn_indicator.dart';
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
      if (player.hp.currentHP < player.hp.maxHP) {
        player.hp.heal(1.toDecimal());
      }
    }
  }

  void startBattle() {
    inBattle = true;
    activeFight = true;
  }

  void firstAttacksSecond(Fighter first, Fighter second) {
    if (second.hp.currentHP - first.attack.attack <= 0.toDecimal()) {
      setState(() {
        second.hp.setCurrentHP(0.toDecimal());
      });
      if (second is Enemy && first is Player) {
        setState(() {
          second.killed += 1;
          first.changeStat('speed', 500);
          first.changeStat('attack', Decimal.parse(".02"));
          first.changeStat('maxHp', Decimal.parse(".01"));
        });
        if (second.killed < second.population) {
          endEncounter();
        } else if (second.killed == second.population) {
          endBattle();
        }
      } else {
        endBattle();
      }
    } else {
      setState(() {
        second.hp.takeDamage(first.attack.attack);
      });
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
    enemy = Bat(2.toDecimal(), enemy.killed);
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
    player = Player(
        Speed(2500), Attack(1.toDecimal()), HP(10.toDecimal(), 10.toDecimal()));
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
                const SizedBox(height: 20),
                Text('${enemy.name} Health: ${enemy.hp.currentHP}'),
                Text('${enemy.name}s Killed: ${enemy.killed}'),
                Text('${enemy.name} Population: ${enemy.population}'),
                TurnIndicator(
                    duration: enemy.speed.speed,
                    onProgressComplete: () {
                      firstAttacksSecond(enemy, player);
                    },
                    isPlaying: activeFight),
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
                Text('Player attack: ${player.attack.attack}'),
                Text('Player speed: ${player.speed.speed}'),
                const SizedBox(height: 20),
                TurnIndicator(
                  duration: int.parse("${player.speed.speed}"),
                  onProgressComplete: () => firstAttacksSecond(player, enemy),
                  isPlaying: activeFight,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HpProgressBar(maxHp: player.hp.maxHP, hp: player.hp.currentHP),
              Text('Player Health: ${player.hp.currentHP}/ ${player.hp.maxHP}')
            ],
          ),
        ],
      ),
    );
  }
}
