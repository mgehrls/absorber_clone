import 'package:decimal/decimal.dart';
import 'fighter.dart';
import 'package:riverpod/riverpod.dart';

import 'stats.dart';

class PlayerNotifier extends StateNotifier<Fighter> {
  PlayerNotifier()
      : super(Fighter(
          Speed(2000),
          Attack(1.toDecimal()),
          HP(10.toDecimal(), 10.toDecimal()),
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
