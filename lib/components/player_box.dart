import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'package:flame_game_jam_dexters/components/item.dart';

class PlayerBox extends PositionComponent with HasGameRef<MyGame> {
  Player player;
  late Rect box;
  Paint paint = Paint();
  final Color color = const Color(0xffdddddd);
  Stage stage;
  late dynamic stageRows;
  double time = 0.0;
  bool shouldRender = false;
  Match match;

  PlayerBox(this.player, this.stage, this.match, x, y, width, height) {
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    stageRows = stage.readStage();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    double boxWidth = (gameSize.x / 4);
    x = gameSize.x / 2 - width / 2;
    box = Rect.fromLTWH(
        ((gameSize.x / 2) - (boxWidth / 2)), 0, boxWidth, gameSize.y);

    player.x = width / 2;
    player.y = gameSize.y - height / 5;

    Stage.distanceBetweenItems = width / 3 - width / 10;

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

  @override
  void update(double dt) {
    time += dt;

    if (match.status == MatchStatus.started && time % 0.2 > 0.1) {
      shouldRender = true;
    }

    if (stageRows.isNotEmpty && shouldRender && time % 0.2 < 0.1) {
      List<Item?> currentRow = stageRows.removeFirst();
      for (var item in currentRow) {
        if (item != null) {
          add(item);
        }
      }

      shouldRender = false;
    }
    super.update(dt);
  }
}
