import 'dart:collection';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/item.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends FlameGame with DoubleTapDetector, TapDetector {
  final Background _background = Background();
  late Queue stageRows;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    add(_background);

    stageRows = Stage(stage: 1).readStage();
  }

  double time = 0.0;

  bool shouldRender = false;

  @override
  void update(double dt) {
    time += dt;

    if (time % 0.2 > 0.1) {
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
