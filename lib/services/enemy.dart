import 'package:absorber_clone/services/enemies.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
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
    this.name,
    hp,
    speed,
    magic,
    regeneration,
    attack,
    effects,
    chances,
    resistances,
    this.killed,
    this.population,
    this.statsToGrant,
  ) : super(
          hp,
          speed,
          magic,
          regeneration,
          attack,
          effects,
          chances,
          resistances,
        );

  Enemy newEnemy({
    required String name,
    required HP hp,
    required Speed speed,
    required Decimal magic,
    required Decimal regeneration,
    required Attack attack,
    required List effects,
    required List chances,
    required List resistances,
    required Killed killed,
    required int population,
    required List<StatToGrant> statsToGrant,
  }) {
    return Enemy(
      name,
      hp,
      speed,
      magic,
      regeneration,
      attack,
      effects,
      chances,
      resistances,
      killed,
      population,
      statsToGrant,
    );
  }

  Enemy copyWith({
    String? name,
    HP? hp,
    Speed? speed,
    Decimal? magic,
    Decimal? regeneration,
    Attack? attack,
    List? effects,
    List? chances,
    List? resistances,
    Killed? killed,
    int? population,
    List<StatToGrant>? statsToGrant,
  }) {
    return Enemy(
      name ?? this.name,
      hp ?? this.hp,
      speed ?? this.speed,
      magic ?? this.magic,
      regeneration ?? this.regeneration,
      attack ?? this.attack,
      effects ?? this.effects,
      chances ?? this.chances,
      resistances ?? this.resistances,
      killed ?? this.killed,
      population ?? this.population,
      statsToGrant ?? this.statsToGrant,
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
