import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'fighter.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

import 'stats.dart';

@immutable
class Player extends Fighter {
  final String name;
  final Decimal recovery;

  const Player(
    this.name,
    hp,
    speed,
    magic,
    regeneration,
    this.recovery,
    attack,
    effects,
    chances,
    resistances,
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

  Player copyWith({
    HP? hp,
    Speed? speed,
    Decimal? magic,
    Decimal? regeneration,
    Decimal? recovery,
    Attack? attack,
    List? effects,
    List? chances,
    List? resistances,
  }) {
    return Player(
      name,
      hp ?? this.hp,
      speed ?? this.speed,
      magic ?? this.magic,
      regeneration ?? this.regeneration,
      recovery ?? this.recovery,
      attack ?? this.attack,
      effects ?? this.effects,
      chances ?? this.chances,
      resistances ?? this.resistances,
    );
  }
}

class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier()
      : super(Player(
          "Player",
          HP(10.toDecimal(), 10.toDecimal()),
          Speed(2000),
          0.toDecimal(),
          0.toDecimal(),
          1.toDecimal(),
          Attack(1.toDecimal()),
          const [],
          const [],
          const [],
        ));

  void takeDamage(Decimal damage) {
    state = state.copyWith(hp: state.hp.takeDamage(damage));
  }

  bool isFullHealth() {
    if (state.hp.currentHP == state.hp.maxHP) {
      return true;
    } else {
      return false;
    }
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

  void increaseAttack(Decimal amount) {
    state = state.copyWith(attack: state.attack.increaseAttack(amount));
  }

  void regenHp(Decimal amount) {
    state = state.copyWith(hp: state.hp.heal(amount));
  }

  void absorbStats(List<StatToGrant> statsToGrant) {
    for (StatToGrant stat in statsToGrant) {
      switch (stat.statName) {
        case "attack":
          state = state.copyWith(
              attack: state.attack.increaseAttack(stat.statValue));
          break;
        case "speed":
          state =
              state.copyWith(speed: state.speed.decreaseSpeed(stat.statValue));
          break;
        case "hp":
          state = state.copyWith(hp: state.hp.increaseMaxHP(stat.statValue));
          break;
      }
    }
  }
}

final playerNotifierProvider = StateNotifierProvider<PlayerNotifier, Fighter>(
  (ref) => PlayerNotifier(),
);
