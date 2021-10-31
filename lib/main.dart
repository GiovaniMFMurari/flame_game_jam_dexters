import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flame_game_jam_dexters/components/start.dart';
import 'package:flutter/material.dart';
import 'package:flame_game_jam_dexters/packages/flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';

import 'components/counter.dart';
import 'components/player_box.dart';

class MyGame extends FlameGame
    with
        DoubleTapDetector,
        TapDetector,
        HasCollidables,
        HasKeyboardHandlerComponents {
  late Background background = Background();
  late Match match;
  Counter counter = Counter(0);
  late PlayerBox playerBox;
  Player player = Player();
  Stage stage = Stage(stage: 1);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // FlameAudio.bgm.initialize();
    double boxWidth = (size.x / 4);

    match = Match.empty();
    playerBox = PlayerBox(player, stage, match, ((size.x / 2) - (boxWidth / 2)),
        0, boxWidth, size.y);
    add(background);
    add(match);
    add(playerBox);

    onGameStart();
  }

  onGameStart() {
    match.start();
    counter.count = match.seconds;
    add(counter);
    // FlameAudio.bgm.play('bgm.mp3', volume: 0.0);
  }

  onGameFinish() {
    remove(counter);
    remove(playerBox);
  }

  @override
  void update(double dt) {
    if (match.status == MatchStatus.finished) onGameFinish();
    if (match.status == MatchStatus.started) counter.count = match.seconds;

    super.update(dt);
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Start(),
  ));
}
