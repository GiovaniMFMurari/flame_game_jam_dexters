import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'package:flame_game_jam_dexters/components/item.dart';

import 'counter.dart';

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
  Counter score = Counter(0, 0, 0);

  late double ratePositionX;
  late double ratePositionY;

  PlayerBox(this.player, this.stage, this.match, this.ratePositionX,
      this.ratePositionY, width, height) {
    paint.color = color;
    paint.style = PaintingStyle.stroke;

    this.width = width;
    this.height = height;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    double boxWidth = (gameSize.x / 4);
    x = gameSize.x / ratePositionX - width / 2;
    box = Rect.fromLTWH(((gameSize.x / ratePositionX) - (boxWidth / 2)), 0,
        boxWidth, gameSize.y);

    player.initialX = width / 2;
    player.x = width / 2;
    player.y = gameSize.y - height / 5;

    Stage.distanceBetweenItems = width / 3 - width / 10;
    stage.initialX = width / 4;
    stageRows = stage.readStage();

    score.x = width / 2;
    score.y = height - height / 10;

    super.onGameResize(gameSize);
  }

  @override
  Future<void>? onLoad() {
    box = Rect.fromLTWH(x, y, width, height);
    add(player);
    add(score);
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

    score.count = player.score;

    super.update(dt);
  }
}
