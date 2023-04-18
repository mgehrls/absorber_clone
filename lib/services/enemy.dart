import 'package:absorber_clone/services/enemies.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'fighter.dart';
import 'stats.dart';

@immutable
class Enemy extends Fighter {
  final String name;
  final Killed killed;
  final int population;
  final List<StatToGrant> statsToGrant;

  const Enemy(
    speed,
    attack,
    hp,
    this.name,
    this.killed,
    this.population,
    this.statsToGrant,
  ) : super(speed, attack, hp);

  Enemy newEnemy({
    required Speed speed,
    required Attack attack,
    required HP hp,
    required String name,
    required Killed killed,
    required int population,
    required List<StatToGrant> statsToGrant,
  }) {
    return Enemy(
      speed,
      attack,
      hp,
      name,
      killed,
      population,
      statsToGrant,
    );
  }

  @override
  Enemy copyWith({
    Speed? speed,
    Attack? attack,
    HP? hp,
    Killed? killed,
  }) {
    return Enemy(
      speed ?? this.speed,
      attack ?? this.attack,
      hp ?? this.hp,
      name,
      killed ?? this.killed,
      population,
      statsToGrant,
    );
  }
}

class EnemyNotifier extends StateNotifier<Enemy> {
  EnemyNotifier(Enemy fighter) : super(fighter);

  void killed() {
    state = state.copyWith(killed: state.killed.incrementKilled());
  }

  void newEnemy(Enemy enemy) {
    state = enemy;
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

final enemyNotifierProvider = StateNotifierProvider<EnemyNotifier, Enemy>(
    (ref) => EnemyNotifier(ref.read(enemyListProvider.notifier).getNewEnemy()));
