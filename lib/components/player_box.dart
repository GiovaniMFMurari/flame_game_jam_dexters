import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';

class PlayerBox extends PositionComponent with HasGameRef<MyGame> {
  Player player;
  late Rect box;
  Paint paint = Paint();
  final Color color = const Color(0xffdddddd);

  PlayerBox(this.player, x, y, width, height) {
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    double boxWidth = (gameSize.x / 4);
    box = Rect.fromLTWH(
        ((gameSize.x / 2) - (boxWidth / 2)), 0, boxWidth, gameSize.y);

    print(player.x);
    print(player.y);
    player.x = width / 2;
    player.y = gameSize.y - player.height * 2;
    print(
        '=============================================================================================');
    print(gameSize);

    super.onGameResize(gameSize);
  }

  @override
  Future<void>? onLoad() {
    box = Rect.fromLTWH(x, y, width, height);
    add(player);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(box, paint);
    super.render(canvas);
  }
}
