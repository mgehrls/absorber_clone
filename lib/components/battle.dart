import 'dart:async';
import 'package:decimal/decimal.dart';

import '../services/globals.dart';
import '../services/player.dart';
import '../services/enemy.dart';
import '../services/enemies.dart';
import 'package:absorber_clone/services/fighter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'turn_indicator.dart';

Decimal calculateDamageGiven(Decimal attack) {
  Decimal damage = attack;
  if (damage < Decimal.zero) {
    damage = Decimal.zero;
  }
  return damage;
}

class BattleComponent extends ConsumerWidget {
  const BattleComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final enemy = ref.watch(enemyNotifierProvider);
    final inBattle = ref.watch(inBattleProvider);
    // ignore: unused_local_variable
    late Timer respawn; // it is used in the onProgressComplete callback.

    void playerAttacksEnemy(Fighter player, Enemy enemy) async {
      //sort out damage to enemy and side effects, apply them to each side before the next section
      Decimal damage = calculateDamageGiven(player.attack.attack);
      ref.read(enemyNotifierProvider.notifier).takeDamage(damage);

      //logic dealing with enemy death
      if (enemy.hp.isDead() && !player.hp.isDead()) {
        ref
            .read(playerNotifierProvider.notifier)
            .absorbStats(enemy.statsToGrant);
        ref.read(enemyNotifierProvider.notifier).killed();
        ref.read(enemyListProvider.notifier).killedEnemy(enemy);
        if (!ref.read(enemyListProvider.notifier).isEnemyAvailable()) {
          ref.read(inBattleProvider.notifier).state = false;
          print("you win!");
        }

        respawn = Timer(const Duration(seconds: 1), () {
          if (ref.watch(enemyNotifierProvider).killed.killed ==
                  ref.watch(enemyNotifierProvider).population &&
              !ref.watch(autoBattleProvider)) {
            ref.read(inBattleProvider.notifier).state = false;
          } else if (ref.watch(enemyNotifierProvider).killed.killed ==
                  ref.watch(enemyNotifierProvider).population &&
              ref.watch(autoBattleProvider)) {
            ref
                .read(enemyNotifierProvider.notifier)
                .newEnemy(ref.read(enemyListProvider.notifier).getNewEnemy());
            ref.read(enemyNotifierProvider.notifier).respawn();
          } else if (ref.watch(enemyNotifierProvider).killed.killed <
              ref.watch(enemyNotifierProvider).population) {
            ref.read(enemyNotifierProvider.notifier).respawn();
          } else {
            throw Exception(
                "Something happened in death logic of playerAttacksEnemy");
          }
        });
      } // end of enemy death logic
    }

    void enemyAttacksPlayer(Fighter player, Enemy enemy) {
      Decimal damage = calculateDamageGiven(enemy.attack.attack);
      ref.read(playerNotifierProvider.notifier).takeDamage(damage);

      if (player.hp.isDead()) {
        ref
            .read(enemyNotifierProvider.notifier)
            .newEnemy(ref.read(enemyListProvider.notifier).getNewEnemy());
        ref.read(enemyNotifierProvider.notifier).respawn();
        ref.read(inBattleProvider.notifier).state = false;
      }
    }

    Column playerBattleDisplay(
        Fighter player, TurnIndicator playerTurnIndicator) {
      return Column(
        children: [
          Text(
              "${player.hp.currentHP.toString()} / ${player.hp.maxHP.toString()}"),
          playerTurnIndicator,
        ],
      );
    }

    Column enemyBattleDisplay(TurnIndicator enemyTurnIndicator, Enemy enemy) {
      return Column(
        children: [
          enemyTurnIndicator,
          Column(
            children: [
              Text(enemy.name),
              Text(
                  "${enemy.hp.currentHP.toString()} / ${enemy.hp.maxHP.toString()}"),
              Text(enemy.killed.killed.toString()),
            ],
          ),
        ],
      );
    }

    TurnIndicator playerTurnIndicator = TurnIndicator(
        duration: player.speed.speed,
        onProgressComplete: () => playerAttacksEnemy(player, enemy),
        isPlaying: inBattle &&
            !player.hp.isDead() &&
            !enemy.hp.isDead() &&
            enemy.killed.killed < enemy.population);
    TurnIndicator enemyTurnIndicator = TurnIndicator(
        duration: enemy.speed.speed,
        onProgressComplete: () => enemyAttacksPlayer(player, enemy),
        isPlaying: inBattle &&
            !enemy.hp.isDead() &&
            !player.hp.isDead() &&
            enemy.killed.killed < enemy.population);

    if (inBattle) {
      return Column(
        children: [
          enemyBattleDisplay(enemyTurnIndicator, enemy),
          const SizedBox(
            height: 100,
          ),
          playerBattleDisplay(player, playerTurnIndicator),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text("Recovering..."),
          playerBattleDisplay(player, playerTurnIndicator),
        ],
      );
    }
  }
}
