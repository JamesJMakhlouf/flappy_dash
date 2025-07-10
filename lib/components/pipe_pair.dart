import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/components/hidden_coin.dart';
import 'package:flappy_dash/components/pipe.dart';

class PipePair extends PositionComponent with FlameBlocReader<GameCubit, GameState> {

  final double gap;
  final double speed;

  final _fixedDeltaTime = 1 / 60;
  double _accumulatedTime = 0;

  PipePair({required super.position, this.gap = 300, this.speed = 200});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      Pipe(isFlipped: false, position: Vector2(0, gap / 2)),
      Pipe(isFlipped: true, position: Vector2(0, -(gap / 2))),
      HiddenCoin(position: Vector2(40, 0)),
    ]);
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
      case PlayingState.paused:
      case PlayingState.gameOver:
        break;
      case PlayingState.playing:
        _accumulatedTime += dt;
        while (_accumulatedTime >= _fixedDeltaTime) {
          position.x -= speed * _fixedDeltaTime;

          _accumulatedTime -= _fixedDeltaTime;
        }
        super.update(dt);
        break;
      // default:
    }
  }

}