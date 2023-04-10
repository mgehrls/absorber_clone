import 'package:absorber_clone/models/attack.dart';
import 'package:absorber_clone/models/hp.dart';
import 'package:absorber_clone/models/speed.dart';
import 'package:decimal/decimal.dart';

class Fighter {
  Speed speed;
  Attack attack;
  HP hp;

  Fighter(this.speed, this.attack, this.hp);
}
