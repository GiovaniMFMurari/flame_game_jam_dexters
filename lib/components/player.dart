import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/item.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flame_game_jam_dexters/main.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<MyGame>, Hitbox, Collidable, KeyboardHandler {
  static final dimensions = Vector2(128, 128);
  late double initialX;
  double score = 0.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = dimensions;

    anchor = Anchor.center;

    addHitbox(HitboxRectangle());

    animation = await gameRef.loadSpriteAnimation(
      'ghost.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent key, keys) {
    final isDown = key is RawKeyDownEvent;

    if (isDown) {
      if (key.logicalKey == LogicalKeyboardKey.keyA) {
        x = initialX - Stage.distanceBetweenItems;
        return true;
      }
      if (key.logicalKey == LogicalKeyboardKey.keyD) {
        x = initialX + Stage.distanceBetweenItems;
        return true;
      }
    }

    x = initialX;
    return false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Item) {
      if (score + other.score < 0) {
        score = 0;
      } else {
        score += other.score;
      }

      print('Current score is: $score');
      other.shouldRemove = true;
    }

    super.onCollision(intersectionPoints, other);
  }
}
