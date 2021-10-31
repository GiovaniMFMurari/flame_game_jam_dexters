import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_game_jam_dexters/components/item.dart';
import 'package:flame_game_jam_dexters/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<MyGame>, Hitbox, Collidable {
  static final dimensions = Vector2(128, 128);
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
