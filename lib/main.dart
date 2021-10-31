import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flame_game_jam_dexters/components/stage.dart';
import 'package:flame_game_jam_dexters/components/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'components/counter.dart';
import 'components/player_box.dart';
import 'packages/flame_audio/flame_audio.dart';

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

  Player player1 = Player.withCustomControls(
      leftKey: LogicalKeyboardKey.keyA, rightKey: LogicalKeyboardKey.keyD);

  Stage stagePlayer1 = Stage(stage: 1);

  @override
  void onGameResize(Vector2 canvasSize) {
    counter.x = canvasSize.x / 2;

    super.onGameResize(canvasSize);
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    FlameAudio.bgm.initialize();
    double boxWidth = (size.x / 4);

    match = Match.empty();

    playerBox1 =
        PlayerBox(player1, stagePlayer1, match, 2, 0, boxWidth, size.y);

    add(background);
    add(match);
    add(playerBox1);

    onGameStart();
  }

  onGameStart() {
    match.start();
    counter.count = match.seconds;
    add(counter);
    FlameAudio.bgm.play('bgm.mp3', volume: 0.0);
  }

  drawGameOver() {
    final TextPaint textPaint = TextPaint(
      config: const TextPaintConfig(
        fontSize: 48.0,
        fontFamily: 'Shlop',
        color: Color(0xfff56300),
      ),
    );

    var gameOver = TextComponent('FINISHED',
        textRenderer: textPaint, position: Vector2(size.x / 2, size.y / 4))
      ..anchor = Anchor.topCenter;

    var scoreText = TextComponent('SCORE: ${player1.score.toString()}',
        textRenderer: textPaint,
        position: Vector2(size.x / 2, (size.y / 4) + (size.y / 5)))
      ..anchor = Anchor.topCenter;

    add(gameOver);
    add(scoreText);
  }

  onGameFinish() {
    remove(counter);
    remove(playerBox1);
    drawGameOver();
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
