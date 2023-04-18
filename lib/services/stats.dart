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

  HP increaseMaxHP(Decimal amount) {
    _maxHP += amount;
    return HP(_currentHP += amount, _maxHP);
  }

  HP decreaseMaxHP(Decimal amount) {
    _maxHP -= amount;
    if (_currentHP > _maxHP) {
      _currentHP = _maxHP;
    }
    return HP(_currentHP, _maxHP);
  }

  HP takeDamage(Decimal damage) {
    _currentHP -= damage;
    if (_currentHP < 0.toDecimal()) {
      _currentHP = 0.toDecimal();
    }
    return HP(_currentHP, _maxHP);
  }

  HP setCurrentHP(Decimal amount) {
    _currentHP = amount;
    return HP(_currentHP, maxHP);
  }

  HP heal(Decimal amount) {
    _currentHP += amount;
    if (_currentHP > _maxHP) {
      _currentHP = _maxHP;
    }
    return HP(_currentHP, _maxHP);
  }

  bool isFull() {
    if (_currentHP == _maxHP) {
      return true;
    } else {
      return false;
    }
  }

  bool isDead() {
    return _currentHP <= 0.toDecimal();
  }
}

class Attack {
  Decimal _attack;

  Attack(this._attack);

  Decimal get attack => _attack;

  Attack increaseAttack(Decimal amount) {
    return Attack(_attack += amount);
  }

  Attack decreaseAttack(Decimal amount) {
    return Attack(_attack -= amount);
  }
}

class Speed {
  late int _speed;
  late int _xSpeed;

  Speed(int speed) {
    _speed = speed;
    _xSpeed = 0;
  }

  int get speed => _speed;
  int get xSpeed => _xSpeed;
  int get totalSpeed => _speed + _xSpeed;

  Speed increaseSpeed(int amount) {
    return Speed(_speed += amount);
  }

  Speed decreaseSpeed(int amount) {
    if (_speed < 110) {
      int newX = 110 - _speed;
      increaseXSpeed(newX);
      return Speed(110);
    } else {
      return Speed(_speed -= amount);
    }
  }

  void increaseXSpeed(int amount) {
    _xSpeed += amount;
  }

  void decreaseXSpeed(int amount) {
    _xSpeed -= amount;
    if (_xSpeed < 0) {
      _xSpeed = 0;
    }
  }
}

class Killed {
  int _killed = 0;

  Killed(int killed) {
    _killed = killed;
  }

  int get killed => _killed;

  Killed incrementKilled() {
    return Killed(_killed + 1);
  }
}

class StatToGrant {
  late String statName;
  late dynamic statValue;

  StatToGrant(this.statName, this.statValue);
}
