import 'package:decimal/decimal.dart';

import 'fighter.dart';

class Player extends Fighter {
  Player(int speed, Decimal attack, Decimal maxHp, Decimal hp)
      : super(speed, attack, maxHp, hp);

  void absorbStat(String stat, dynamic number) {
    switch (stat) {
      case 'speed':
        speed += number as int;
        break;
      case 'attack':
        attack += Decimal.parse(number.toString());
        break;
      case 'maxHp':
        maxHp += Decimal.parse(number.toString());
        break;
      default:
    }
  }
}
