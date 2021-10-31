import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
import 'package:flame_game_jam_dexters/components/match.dart';
import 'package:flame_game_jam_dexters/components/player.dart';
import 'package:flutter/widgets.dart';

import 'components/counter.dart';

class MyGame extends FlameGame with DoubleTapDetector, TapDetector {
  late Background background = Background();
  late Match match;
  Counter counter = Counter(0);
  Player player = Player();

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    match = Match.empty();
    add(background);
    add(match);
    add(player);
  }

  onGameStart() {
    match.start();
    counter.count = match.seconds;
    add(counter);
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
