import 'package:decimal/decimal.dart';

class Attack {
  Decimal _attack;

  Attack(this._attack);

  Decimal get attack => _attack;

  void increaseAttack(Decimal amount) {
    _attack += amount;
  }

  void decreaseAttack(Decimal amount) {
    _attack -= amount;
  }
}
