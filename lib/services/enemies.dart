import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'enemy.dart';
import 'stats.dart';

class DefaultEnemyList {
  List<Enemy> enemies = [
    Enemy(Speed(1000), Attack(Decimal.parse(".3")),
        HP(2.toDecimal(), 2.toDecimal()), 'Bat', Killed(0), 200, [
      StatToGrant('attack', Decimal.parse(".02")),
      StatToGrant('speed', 1),
      StatToGrant("hp", Decimal.parse(".01"))
    ]),
    Enemy(
        Speed(1200),
        Attack(Decimal.parse(".05")),
        HP(3.toDecimal(), 3.toDecimal()),
        "Worm",
        Killed(0),
        2,
        [StatToGrant("attack", Decimal.parse(".01")), StatToGrant("speed", 1)]),
  ];
}

class EnemyListNotifer extends StateNotifier<List<Enemy>> {
  EnemyListNotifer(List<Enemy> enemies) : super(enemies);

  Enemy getNewEnemy() {
    return state
        .firstWhere((element) => element.killed.killed < element.population);
  }

  void killedEnemy(Enemy enemy) {
    state = state.map((e) {
      if (e.name == enemy.name) {
        return e.copyWith(
            hp: HP(e.hp.maxHP, e.hp.maxHP), killed: e.killed.incrementKilled());
      } else {
        return e;
      }
    }).toList();
  }
}

final enemyListProvider = StateNotifierProvider<EnemyListNotifer, List<Enemy>>(
    (ref) => EnemyListNotifer(DefaultEnemyList().enemies));
