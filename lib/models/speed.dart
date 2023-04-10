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

  void increaseSpeed(int amount) {
    _speed += amount;
  }

  void decreaseSpeed(int amount) {
    if (_speed < 110) {
      int newX = 110 - _speed;
      increaseXSpeed(newX);
      _speed = 110;
    } else {
      _speed -= amount;
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
