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
    var size = gameRef.size;
    textComponent = TextComponent(count.toString(),
        textRenderer: textPaint, position: Vector2((size.x / 2), _y));
    add(textComponent);
    super.onLoad();
  }

  @override
  void update(double dt) {
    textComponent.text = count.toInt().toString();
    super.update(dt);
  }
}
