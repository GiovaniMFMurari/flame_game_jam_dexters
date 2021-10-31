import 'package:flame/components.dart';

import '../main.dart';

class Treat extends SpriteComponent with HasGameRef<MyGame> {
  late double gravity;
  late double endY;
  late Vector2 initialPosition;
  double speedY = 0.0;

  Treat.empty() {
    gravity = 200.0;
    endY = 500.0;
    initialPosition = Vector2.all(0);
  }

  Treat(this.gravity, this.endY, this.initialPosition);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    x = initialPosition.x;
    y = initialPosition.y;

    width = 32;
    height = 32;

    sprite = await gameRef.loadSprite('candy.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (y > endY) return;

    y += speedY * dt - gravity * dt * dt / 2;

    speedY += gravity * dt;
  }
}
