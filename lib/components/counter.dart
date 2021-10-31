import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';

class Counter extends Component with HasGameRef {
  double count = 0;
  final double _y = 10;
  late TextComponent textComponent;

  Counter(this.count);

  final TextPaint textPaint = TextPaint(
    config: TextPaintConfig(
      fontSize: 48.0,
      fontFamily: 'Shlop',
      color: BasicPalette.white.color,
    ),
  );

  @override
  Future<void> onLoad() async {
    textComponent = TextComponent(count.toString(),
        textRenderer: textPaint, position: Vector2((gameRef.size.x / 2), _y))
      ..anchor = Anchor.topCenter;
    add(textComponent);
    super.onLoad();
  }

  @override
  void update(double dt) {
    textComponent.x = gameRef.size.x / 2;
    textComponent.text = count.toInt().toString();
    super.update(dt);
  }
}
