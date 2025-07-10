import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/components/hidden_coin.dart';
import 'package:flappy_dash/components/pipe.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

class Dash extends PositionComponent with CollisionCallbacks, HasGameReference<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {

  late Sprite _dashSprite;

  final Vector2 _gravity = Vector2(0, 1400);
  final Vector2 _jumpForce = Vector2(0, -500);
  final Vector2 _terminalVelocity = Vector2(0, 1000);
  Vector2 _velocity = Vector2.zero();

  final double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  Dash() : super(
    position: Vector2.zero(),
    size: Vector2.all(80),
    anchor: Anchor.center
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = 1;
    // debugMode = true;
    final center = size / 2;
    final radius = size.x / 2;
    add(CircleHitbox(
      position: center * 1.075,
      anchor: Anchor.center,
      radius: radius * 0.8,
      collisionType: CollisionType.active,
    ));
    _dashSprite = await Sprite.load('dash.png');
  }

  @override
  void update(double dt) {
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    accumulatedTime += dt;
    while(accumulatedTime >= fixedDeltaTime) {
      super.update(fixedDeltaTime);

      _updateAngle();
      if (_velocity.y < _terminalVelocity.y) {
        _velocity += _gravity * fixedDeltaTime;
      } else {
        _velocity = _terminalVelocity;
      }
      position += _velocity * fixedDeltaTime;

      accumulatedTime -= fixedDeltaTime;
    }
  }

  void jump() {
    _velocity = _jumpForce;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    if (other is HiddenCoin) {
      other.removeFromParent();
      bloc.increaseScore();
    }
    if (other is Pipe) {
      bloc.gameOver();
    }
  }
  
  void _updateAngle() {
    final dividingVelocity = _velocity.y > 0 ? _terminalVelocity : -_jumpForce;
    angle =  lerpDouble(angle, _velocity.y / (dividingVelocity.y * 1.5) * pi / 2, 0.15)!;
  }

}