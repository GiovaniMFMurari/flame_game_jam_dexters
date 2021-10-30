import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flutter/painting.dart';

import '../main.dart';

class Background extends Component with HasGameRef<MyGame> {
  late Image _image;
  late Player _player;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    add(_player = Player());
    _image = await Flame.images.load('background.png');
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawImageRect(
        _image,
        Rect.fromLTWH(0, 0, _image.width.toDouble(), _image.height.toDouble()),
        Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y),
        paint);
    super.render(canvas);
  }
}
