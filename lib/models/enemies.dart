// ignore_for_file: overridden_fields, unused_field

import 'package:absorber_clone/models/attack.dart';
import 'package:absorber_clone/models/hp.dart';
import 'package:absorber_clone/models/speed.dart';
import 'package:decimal/decimal.dart';

import 'fighter.dart';

abstract class Enemy extends Fighter {
  final Speed _speed;
  final Attack _attack;
  final HP _hp;
  int killed;
  late int population;
  late String name;

  Enemy(Speed speed, Attack attack, HP hp, this.killed, int population,
      String name)
      : _speed = speed,
        _attack = attack,
        _hp = hp,
        super(speed, attack, hp) {
    this.name = name;
  }

  int getPopulation() => population;

  String getName() => name;
}

String name = "Matt";

class Bat extends Enemy {
  // define population in the subclass
  final int _population = 200;
  @override
  final Speed _speed;
  final Decimal _maxHp;
  final Attack _attack;
  final String _name;
  late final int _killed;
  String name = "Bat";

  Bat(Decimal hp, int newKilled)
      : _speed = Speed(1000),
        _maxHp = 2.toDecimal(),
        _attack = Attack(Decimal.parse(".3")),
        _name = "Bat",
        _killed = newKilled,
        super(
          Speed(1000),
          Attack(Decimal.parse(".3")),
          HP(2.toDecimal(), 2.toDecimal()),
          newKilled,
          200,
          "Bat",
        );

  // implement the population getter in the subclass
  @override
  int get population => _population;

  // other methods and properties...
}
