import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_game_jam_dexters/components/background.dart';
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

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    add(_background);
  }
}
