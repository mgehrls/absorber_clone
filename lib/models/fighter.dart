class Fighter {
  double hp;
  double maxHp;
  int speed;
  double recovery;
  double dmg;
  double def;
  bool inBattle;
  var effects;
  late Duration speedDuration; // new variable for storing speed duration

  Fighter({
    required this.hp,
    required this.maxHp,
    required this.speed,
    required this.recovery,
    required this.dmg,
    required this.def,
    this.inBattle = true,
    required String name,
    required Duration speedDuration,
  }) {
    this.speedDuration = Duration(
        milliseconds: speed); // calculate speed duration as a Duration type
  }

  void takeTurn(Fighter enemy) {
    //add regeneration
    attack(enemy);
  }

  void attack(Fighter enemy) {
    bool hit = compareAccuracyAndEvasion();
    double dmgDealt = calculateDamage(enemy.def);

    if (hit) {
      takeAttackSideEffects();
      enemy.defend(dmgDealt, effects);
    }
  }

  bool compareAccuracyAndEvasion() {
    // TODO: implement accuracy and evasion comparison
    return true;
  }

  double calculateDamage(double enemyDef) {
    // TODO: implement damage calculation
    return dmg - enemyDef;
  }

  void defend(double dmgDealt, sideEffects) {
    hp -= dmgDealt;
    takeDefenseSideEffects(sideEffects);

    if (hp <= 0) {
      die();
    }
  }

  void takeAttackSideEffects() {
    // TODO: implement attack side effects
  }

  void takeDefenseSideEffects(sideEffects) {
    // TODO: implement defense side effects
  }

  void die() {
    inBattle = false;
  }
}
