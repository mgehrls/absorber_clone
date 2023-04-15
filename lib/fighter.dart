import 'package:flutter/material.dart';
import 'stats.dart';

@immutable
class Fighter {
  final Speed speed;
  final Attack attack;
  final HP hp;

  const Fighter(this.speed, this.attack, this.hp);

  Fighter copyWith({
    Speed? speed,
    Attack? attack,
    HP? hp,
  }) {
    return Fighter(
      speed ?? this.speed,
      attack ?? this.attack,
      hp ?? this.hp,
    );
  }
}



// ignore: camel_case_types


