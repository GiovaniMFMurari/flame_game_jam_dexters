import 'package:flame/components.dart';

import '../main.dart';

class Trick extends SpriteComponent with HasGameRef<MyGame> {
  double gravity = 200.0;
  double speedY = 0.0;
  double endY = 500.0;
  Vector2 initialPosition = Vector2(0, 0);

  Trick.empty();

  Trick(this.gravity, this.endY, this.initialPosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = initialPosition.x;
    y = initialPosition.y;

    width = 32;
    height = 32;

    sprite = await gameRef.loadSprite('trick.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (y > endY) return;

    y += speedY * dt - gravity * dt * dt / 2;

    speedY += gravity * dt;
  }
}
