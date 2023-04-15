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

final playerNotifierProvider = StateNotifierProvider<PlayerNotifier, Fighter>(
  (ref) => PlayerNotifier(),
);
