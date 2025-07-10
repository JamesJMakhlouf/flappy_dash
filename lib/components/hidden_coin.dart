import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HiddenCoin extends PositionComponent {

  HiddenCoin({required super.position}) : super (
    size: Vector2(1, 300),
    anchor: Anchor.centerLeft,
  );

  @override
  void onLoad() {
    // debugMode = true;
    add(RectangleHitbox(
      collisionType: CollisionType.passive,
    ));
    super.onLoad();
  }
}