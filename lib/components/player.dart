import 'package:flame/components.dart';
import 'package:flame_game_jam_dexters/main.dart';

class Player extends SpriteAnimationComponent with HasGameRef<MyGame> {
  static final dimensions = Vector2(32, 32);

  Player() {
    height = 128;
    width = 128;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    animation = await gameRef.loadSpriteAnimation(
      'ghost.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
