import 'package:decimal/decimal.dart';

class HP {
  late Decimal _maxHP;
  late Decimal _currentHP;

  HP(Decimal cHp, Decimal mHP) {
    if (cHp > mHP) {
      _currentHP = mHP;
      _maxHP = mHP;
    } else {
      _currentHP = cHp;
      _maxHP = mHP;
    }
  }

  Decimal get currentHP => _currentHP;
  Decimal get maxHP => _maxHP;

  void increaseMaxHP(Decimal amount) {
    _maxHP += amount;
    _currentHP += amount > _maxHP ? _currentHP = _maxHP : _currentHP += amount;
  }

  void decreaseMaxHP(Decimal amount) {
    _maxHP -= amount;
    if (_currentHP > _maxHP) {
      _currentHP = _maxHP;
    }
  }

  void takeDamage(Decimal damage) {
    _currentHP -= damage;
    if (_currentHP < 0.toDecimal()) {
      _currentHP = 0.toDecimal();
    }
  }

  void setCurrentHP(Decimal amount) {
    _currentHP = amount;
  }

  void heal(Decimal amount) {
    _currentHP += amount;
    if (_currentHP > _maxHP) {
      _currentHP = _maxHP;
    }
  }

  bool isDead() {
    return _currentHP <= 0.toDecimal();
  }
}
