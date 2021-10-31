import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'dart:collection';
import 'package:flame_game_jam_dexters/components/item.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flame_game_jam_dexters/packages/flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';

import 'components/counter.dart';
import 'components/player_box.dart';

class MyGame extends FlameGame with DoubleTapDetector, TapDetector {
  late Background background = Background();
  late Match match;
  Counter counter = Counter(0);
  late PlayerBox playerBox;
  Player player = Player();
  late Queue stageRows;
  double time = 0.0;
  bool shouldRender = false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

//    FlameAudio.bgm.initialize();
    double boxWidth = (size.x / 4);

    playerBox =
        PlayerBox(player, ((size.x / 2) - (boxWidth / 2)), 0, boxWidth, size.y);
    match = Match.empty();
    add(background);
    add(match);
    stageRows = Stage(stage: 1).readStage();
    add(playerBox);
  }

  onGameStart() {
    match.start();
    counter.count = match.seconds;
    add(counter);
    //  FlameAudio.bgm.play('bgm.mp3', volume: 0.0);
  }

  onGameFinish() {
    remove(counter);
  }

  @override
  onTap() {
    onGameStart();
  }

  @override
  void update(double dt) {
    if (match.status == MatchStatus.finished) onGameFinish();
    if (match.status == MatchStatus.started) counter.count = match.seconds;

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

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}
