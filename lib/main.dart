import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flame_game_jam_dexters/components/start.dart';
import 'package:flutter/material.dart';
import 'package:flame_game_jam_dexters/packages/flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
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
  Counter counter = Counter(0, 10, 0);
  late PlayerBox playerBox1;
  late PlayerBox playerBox2;

  Player player1 = Player.withCustomControls(
      leftKey: LogicalKeyboardKey.keyA, rightKey: LogicalKeyboardKey.keyD);
  Player player2 = Player.withCustomControls(
      leftKey: LogicalKeyboardKey.keyJ, rightKey: LogicalKeyboardKey.keyL);

  Stage stagePlayer1 = Stage(stage: 1);
  Stage stagePlayer2 = Stage(stage: 1);

  @override
  void onGameResize(Vector2 canvasSize) {
    counter.x = canvasSize.x / 2;

    super.onGameResize(canvasSize);
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // FlameAudio.bgm.initialize();
    double boxWidth = (size.x / 4);

    match = Match.empty();

    playerBox1 =
        PlayerBox(player1, stagePlayer1, match, 1.5, 0, boxWidth, size.y);
    playerBox2 =
        PlayerBox(player2, stagePlayer2, match, 3, 0, boxWidth, size.y);

    add(background);
    add(match);
    add(playerBox1);
    add(playerBox2);

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
    remove(playerBox1);
    remove(playerBox2);
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
    title: 'Treat Time! - powered by Flame Engine',
  ));
}
