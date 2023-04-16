import 'dart:async';
import '../services/globals.dart';
import '../services/player.dart';
import '../services/enemy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'turn_indicator.dart';

class BattleComponent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final enemy = ref.watch(enemyNotifierProvider);
    final inBattle = ref.watch(inBattleProvider);
    final time = ref.watch(timeNotifierProvider);

    // ignore: unused_local_variable
    late Timer respawn; // it is used in the onProgressComplete callback.

    TurnIndicator playerTurnIndicator = TurnIndicator(
        duration: player.speed.speed,
        onProgressComplete: () => {
              ref
                  .read(enemyNotifierProvider.notifier)
                  .takeDamage(player.attack.attack),
              if (enemy.hp.isDead())
                {
                  ref
                      .read(playerNotifierProvider.notifier)
                      .absorbStats(enemy.statsToGrant),
                  ref.read(enemyNotifierProvider.notifier).killed(),
                  if (enemy.killed.killed == enemy.population)
                    {
                      ref.read(inBattleProvider.notifier).state = false,
                    }
                  else
                    {
                      respawn = Timer(const Duration(seconds: 1), () {
                        ref.read(enemyNotifierProvider.notifier).respawn();
                      })
                    }
                }
            },
        isPlaying: inBattle &&
            !player.hp.isDead() &&
            !enemy.hp.isDead() &&
            enemy.killed.killed < enemy.population);
    TurnIndicator enemyTurnIndicator = TurnIndicator(
        duration: enemy.speed.speed,
        onProgressComplete: () => {
              ref
                  .read(playerNotifierProvider.notifier)
                  .takeDamage(enemy.attack.attack),
              if (player.hp.isDead())
                {
                  ref.read(enemyNotifierProvider.notifier).respawn(),
                  ref.read(inBattleProvider.notifier).state = false,
                }
            },
        isPlaying: inBattle &&
            !enemy.hp.isDead() &&
            !player.hp.isDead() &&
            enemy.killed.killed < enemy.population);

    return Column(
      children: [
        Column(
          children: [
            Text(
                "${player.hp.currentHP.toString()} / ${player.hp.maxHP.toString()}"),
            playerTurnIndicator,
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Column(
          children: [
            enemyTurnIndicator,
            Column(
              children: [
                Text(
                    "${enemy.hp.currentHP.toString()} / ${enemy.hp.maxHP.toString()}"),
                Text(enemy.killed.killed.toString()),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
