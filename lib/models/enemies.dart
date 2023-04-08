// ignore_for_file: overridden_fields, unused_field

import 'package:decimal/decimal.dart';

import 'fighter.dart';

abstract class Enemy extends Fighter {
  late String name;
  late final int _population; // make population private
  late int killed;

  Enemy(int speed, Decimal attack, Decimal maxHp, Decimal hp, this.name,
      int population, this.killed)
      : _population = population,
        super(speed, attack, maxHp, hp);

  int get population => _population; // add a getter method for population
}

class Bat extends Enemy {
  // define population in the subclass
  @override
  final int _population;
  final int _speed;
  final Decimal _maxHp;
  final Decimal _attack;
  final String _name;

  Bat(Decimal hp, int killed)
      : _population = 200,
        _speed = 1000,
        _maxHp = 2.toDecimal(),
        _attack = Decimal.parse("0.3"),
        _name = "Bat",
        super(1000, Decimal.parse(".3"), 2.toDecimal(), 2.toDecimal(), "Bat",
            200, killed);

  // implement the population getter in the subclass
  @override
  int get population => _population;

  // other methods and properties...
}
