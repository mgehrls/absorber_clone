import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'fighter.dart';
import 'stats.dart';

@immutable
class Enemy extends Fighter {
  final Killed killed;
  final int population;

  const Enemy(speed, attack, hp, this.killed, this.population)
      : super(speed, attack, hp);

  @override
  Enemy copyWith({
    Speed? speed,
    Attack? attack,
    HP? hp,
    Killed? killed,
    int? population,
  }) {
    return Enemy(
      speed ?? this.speed,
      attack ?? this.attack,
      hp ?? this.hp,
      killed ?? this.killed,
      population ?? this.population,
    );
  }
}

class EnemyNotifier extends StateNotifier<Enemy> {
  EnemyNotifier(Enemy fighter, int population, int killed) : super(fighter);

  void killed() {
    state = state.copyWith(killed: state.killed.incrementKilled());
  }

  void respawn() {
    state = state.copyWith(hp: state.hp.setCurrentHP(state.hp.maxHP));
  }

  void takeDamage(Decimal damage) {
    state = state.copyWith(hp: state.hp.takeDamage(damage));
  }

  void heal(Decimal amount) {
    state = state.copyWith(hp: state.hp.heal(amount));
  }

  void increaseMaxHP(Decimal amount) {
    state = state.copyWith(hp: state.hp.increaseMaxHP(amount));
  }

  void decreaseMaxHP(Decimal amount) {
    state = state.copyWith(hp: state.hp.decreaseMaxHP(amount));
  }

  void setCurrentHP(Decimal amount) {
    state = state.copyWith(hp: state.hp.setCurrentHP(amount));
  }
}

final enemyNotifierProvider =
    StateNotifierProvider<EnemyNotifier, Enemy>((ref) => EnemyNotifier(
          Enemy(
            Speed(1000),
            Attack(Decimal.parse(".3")),
            HP(2.toDecimal(), 2.toDecimal()),
            Killed(0),
            3,
          ),
          0,
          3,
        ));
