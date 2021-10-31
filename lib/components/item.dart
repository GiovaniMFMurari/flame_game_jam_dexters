import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../main.dart';

class Item extends SpriteComponent with HasGameRef<MyGame>, Hitbox, Collidable {
  double gravity = 200.0;
  double endY = 500.0;
  double speedY = 0.0;
  Vector2 initialPosition = Vector2.all(0);
  late double score;
  late String spriteImg;

  Item.treat(this.initialPosition) {
    spriteImg = 'treat2.png';
    score = 1.0;
  }

  Item.trick(this.initialPosition) {
    spriteImg = 'trick.png';
    score = -3.0;
  }

  Item(this.gravity, this.endY, this.initialPosition, this.score,
      this.spriteImg);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final gameHeight = gameRef.size.y;
    endY = gameHeight - gameHeight / 6;

    x = initialPosition.x;
    y = initialPosition.y;

    width = 32;
    height = 32;

    addHitbox(HitboxRectangle());
    collidableType = CollidableType.passive;

    sprite = await gameRef.loadSprite(spriteImg);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    endY = gameSize.y - gameSize.y / 6;
    super.onGameResize(gameSize);
  }

  void teste() {
    gameRef.remove(this);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (y >= endY) {
      shouldRemove = true;
    }

    y += speedY * dt - gravity * dt * dt / 2;

    speedY += gravity * dt;
  }
}
