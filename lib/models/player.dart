import 'fighter.dart';

class Player extends Fighter {
  int xSpeed;
  int prestige;
  int points;
  late int timePlayed;
  late int fastestRun;

  Player({
    this.xSpeed = 0,
    this.prestige = 0,
    this.points = 0,
    required this.timePlayed,
    required this.fastestRun,
    required String name,
    required double hp,
    required double maxHp,
    required int speed,
    required double recovery,
    required double dmg,
    required double def,
    bool inBattle = false,
  }) : super(
          name: "Player",
          hp: 10,
          maxHp: 10,
          speed: 2500,
          recovery: recovery,
          dmg: dmg,
          def: def,
          speedDuration: const Duration(milliseconds: 2500),
        );

  void absorbStat(String stat, int number) {
    switch (stat) {
      case 'hp':
        hp += number;
        break;
      case 'maxHp':
        maxHp += number;
        break;
      case 'speed':
        speed -= number;
        break;
      case 'recovery':
        recovery += number;
        break;
      case 'dmg':
        dmg += number;
        break;
      default:
        throw Exception('Invalid stat');
    }
  }

  @override
  void die() {
    super.die();
    exitBattle();
  }

  void enterBattle(Fighter enemy) {
    inBattle = true;
    //TODO: implement entering battle logic
  }

  void exitBattle() {
    inBattle = false;
    //TODO: implement exiting battle logic
  }
}
