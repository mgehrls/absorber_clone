import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'enemy.dart';
import 'stats.dart';

class DefaultEnemyList {
  List<Enemy> enemies = [
    Enemy(
        "Bat",
        HP(2.toDecimal(), 2.toDecimal()),
        Speed(1200),
        Decimal.zero,
        Decimal.zero,
        Attack(Decimal.parse(".3")),
        const [],
        const [],
        const [],
        Killed(0),
        200,
        [
          StatToGrant("attack", Decimal.parse(".01")),
          StatToGrant("speed", 2),
          StatToGrant("hp", Decimal.parse("-.01"))
        ]),
    Enemy(
        "Evil Spirit",
        HP(1.toDecimal(), 1.toDecimal()),
        Speed(1900),
        Decimal.zero,
        Decimal.zero,
        Attack(Decimal.one),
        const [],
        const [],
        const [],
        Killed(0),
        300,
        [StatToGrant("speed", 1)]),
    Enemy(
        "Blue Slime",
        HP(5.toDecimal(), 5.toDecimal()),
        Speed(2000),
        Decimal.zero,
        Decimal.parse(".2"),
        Attack(Decimal.parse(".5")),
        const [],
        const [],
        const [],
        Killed(0),
        150,
        [
          StatToGrant("attack", Decimal.parse(".01")),
          StatToGrant("speed", 1),
          StatToGrant("hp", Decimal.parse(".1"))
        ]),
  ];
}

class EnemyListNotifer extends StateNotifier<List<Enemy>> {
  EnemyListNotifer(List<Enemy> enemies) : super(enemies);

  Enemy getNewEnemy() {
    return state
        .firstWhere((element) => element.killed.killed < element.population);
  }

  bool isEnemyAvailable() {
    return state.any((element) => element.killed.killed < element.population);
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
