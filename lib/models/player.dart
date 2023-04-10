import 'package:absorber_clone/models/attack.dart';
import 'package:absorber_clone/models/speed.dart';
import 'package:absorber_clone/models/hp.dart';
import 'package:decimal/decimal.dart';

import 'fighter.dart';

class Player extends Fighter {
  final Speed _speed;
  final Attack _attack;
  final HP _hp;
  String name = "Matt";

  Player(
    Speed speed,
    Attack attack,
    HP hp,
  )   : _speed = speed,
        _attack = attack,
        _hp = hp,
        super(speed, attack, hp);

  void changeStat(String stat, dynamic amount) {
    switch (stat) {
      case 'speed':
        _speed.decreaseSpeed(amount as int);
        break;
      case 'attack':
        _attack.increaseAttack(amount as Decimal);
        break;
      case 'hp':
        _hp.increaseMaxHP(amount as Decimal);
        break;
      default:
        print('Invalid stat!');
    }
  }
}
