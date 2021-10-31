import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/layers.dart';
import 'package:flame_game_jam_dexters/main.dart';

class BackgroundLayer extends PreRenderedLayer {
  Sprite? sprite;
  Vector2? size;

  BackgroundLayer(this.sprite, this.size);
  BackgroundLayer.empty();

  @override
  void drawLayer() {
    sprite?.render(canvas, position: Vector2(0, 0), size: size);
  }
}

class Background extends Component with HasGameRef<MyGame> {
  Vector2 _size = Vector2(0, 0);
  late BackgroundLayer _backgroundLayer = BackgroundLayer.empty();

  @override
  Future<void> onGameResize(Vector2 gameSize) async {
    var _image = await Flame.images.load('background.png');
    Sprite sprite = Sprite(_image);
    _size = gameRef.size;

    _backgroundLayer = BackgroundLayer(sprite, _size);
    _backgroundLayer.size = gameSize;
    super.onGameResize(gameSize);
  }

  @override
  void render(Canvas canvas) {
    _backgroundLayer.render(canvas);

    super.render(canvas);
  }
}
