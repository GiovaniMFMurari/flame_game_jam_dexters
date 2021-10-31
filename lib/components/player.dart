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

  LogicalKeyboardKey leftKey = LogicalKeyboardKey.keyA;
  LogicalKeyboardKey rightKey = LogicalKeyboardKey.keyD;

  Player.withCustomControls(
      {required LogicalKeyboardKey leftKey,
      required LogicalKeyboardKey rightKey}) {
    this.leftKey = leftKey;
    this.rightKey = rightKey;
  }

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
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isDown = event is RawKeyDownEvent;

    if (isDown) {
      if (keysPressed.contains(leftKey)) {
        x = initialX - Stage.distanceBetweenItems;
        return true;
      }
      if (keysPressed.contains(rightKey)) {
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

      other.shouldRemove = true;
    }

    super.onCollision(intersectionPoints, other);
  }
}
