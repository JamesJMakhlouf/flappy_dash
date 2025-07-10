import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pipe extends PositionComponent {

  late Sprite _pipeSprite;

  final bool isFlipped;

  Pipe({required this.isFlipped, required super.position}) : super (
    anchor: Anchor.topCenter
  );

  @override
  FutureOr<void> onLoad() async {
    await  super.onLoad();
    _pipeSprite = await Sprite.load('pipe.png');
    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    const width = 80.0;
    size = Vector2(width, width * ratio);

    add(RectangleHitbox());

    if (isFlipped) {
      position.y -= size.y;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isFlipped) {
      canvas.save();
      canvas.translate(0, size.y);
      canvas.scale(1, -1);
      _pipeSprite.render(canvas, size: size);
      canvas.restore();
    } else {
      _pipeSprite.render(canvas, size: size);
    }
  }
}