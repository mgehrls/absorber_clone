import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "/services/globals.dart";
import "/services/player.dart";
import "/services/enemy.dart";
import "/services/enemies.dart";

class StatPage extends ConsumerWidget {
  const StatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemy = ref.watch(enemyNotifierProvider);
    final inBattle = ref.watch(inBattleProvider);
    final player = ref.watch(playerNotifierProvider);
    final autoBattle = ref.watch(autoBattleProvider);
    final enemyList = ref.watch(enemyListProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text(
                  "${player.hp.currentHP.toString()} / ${player.hp.maxHP.toString()}"),
              Text("${player.speed.speed}"),
              Text("${player.attack.attack}"),
            ]),
            SizedBox(width: 20),
            Column(
              children: [
                Text(enemy.name),
                Text(
                    "${enemy.hp.currentHP.toString()} / ${enemy.hp.maxHP.toString()}"),
                Text("${enemy.speed.speed}"),
                Text("${enemy.attack.attack}"),
                Text("${enemy.killed.killed} / ${enemy.population}"),
              ],
            ),
            SizedBox(width: 20),
            Column(
              children: [
                Text("In Battle: ${inBattle.toString()}"),
                Text("Auto: ${autoBattle.toString()}"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < enemyList.length; i++)
              Column(
                children: [
                  Text("${enemyList[i].name}"),
                  Text(
                      "${enemyList[i].killed.killed} / ${enemyList[i].population}"),
                  Text(
                      "HP: ${enemyList[i].hp.currentHP} / ${enemyList[i].hp.maxHP}"),
                  Text("Speed: ${enemyList[i].speed.speed}"),
                  Text("Attack: ${enemyList[i].attack.attack}"),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
