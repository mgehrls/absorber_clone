import 'package:flutter/material.dart';
import 'dart:async';

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
  late Player player;
  late Enemy enemy;
  late Timer playerTimer;
  late Timer enemyTimer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timePlayed++;
      });
    });
  }

  void startBattle() {
    inBattle = true;
    playerTimer = Timer.periodic(Duration(milliseconds: player.speed), (timer) {
      setState(() {
        firstAttacksSecond(player, enemy);
      });
    });
    enemyTimer = Timer.periodic(Duration(milliseconds: enemy.speed), (timer) {
      setState(() {
        firstAttacksSecond(enemy, player);
      });
    });
  }

  void firstAttacksSecond(Fighter first, Fighter second) {
    second.hp = double.parse((second.hp - first.attack).toStringAsFixed(2));
    if (second.hp <= 0) {
      second.hp = 0;
      if (second is Enemy) {
        second.killed += 1;
        if (second.killed < second.population) {
          delayedFunction(enemyRespawn);
        } else if (second.killed == second.population) {
          endBattle();
        }
      } else {
        endBattle();
      }
    }
  }

  void enemyRespawn() {
    enemy
      ..speed = 1000
      ..attack = 0.3
      ..hp = 2.0;
  }

  void endBattle() {
    inBattle = false;
    playerTimer.cancel();
    enemyTimer.cancel();
  }

  Future<void> delayedFunction(Function x) async {
    await Future.delayed(Duration(milliseconds: 500));
    x();
  }

  @override
  void initState() {
    super.initState();
    player = Player(2500, 1, 10);
    enemy = Enemy(1000, .3, 2, "Bat", 2, 0);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idle RPG'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Time Played: $timePlayed'),
            const SizedBox(height: 20),
            Text('Player Health: ${player.hp}'),
            Text('${enemy.name} Health: ${enemy.hp}'),
            const SizedBox(height: 20),
            inBattle
                ? ElevatedButton(
                    onPressed: endBattle,
                    child: const Text('End Battle'),
                  )
                : ElevatedButton(
                    onPressed: startBattle,
                    child: const Text('Start Battle'),
                  ),
            const SizedBox(height: 20),
            Text('${enemy.name}s Killed: ${enemy.killed}'),
            Text('${enemy.name} Population: ${enemy.population}'),
          ],
        ),
      ),
    );
  }
}

class Fighter {
  int speed;
  double attack;
  double hp;

  Fighter(this.speed, this.attack, this.hp);
}

class Player extends Fighter {
  Player(int speed, double attack, double hp) : super(speed, attack, hp);
}

class Enemy extends Fighter {
  late String name;
  late int population;
  late int killed;

  Enemy(int speed, double attack, double hp, String name, int population,
      int killed)
      : population = population,
        killed = killed,
        name = name,
        super(speed, attack, hp);
}
