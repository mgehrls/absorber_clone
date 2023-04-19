import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'stats.dart';

@immutable
class Fighter {
  final HP hp;
  final Speed speed;
  final Decimal magic;
  final Decimal regeneration; //health restored each turn
  final Attack attack;
  final List effects;
  final List chances;
  final List resistances;

  const Fighter(
    this.hp,
    this.speed,
    this.magic,
    this.regeneration,
    this.attack,
    this.effects,
    this.chances,
    this.resistances,
  );
}





// ignore: camel_case_types


