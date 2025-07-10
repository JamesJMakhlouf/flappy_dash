import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/dash_background.dart';
import 'package:flappy_dash/components/pipe_pair.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

class FlappyDashRootComponent extends Component with HasGameReference<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {

  late Dash _dash;
  late PipePair _lastPipe;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(DashBackground());
    add(_dash = Dash());
    _generatePipes();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_dash.x >= _lastPipe.x) {
      _generatePipes();
      _removeOldPipes();
    }
  }

  void onTapDownOronSpaceDown() {
    _checkToStart();
    _dash.jump();
  }

  void _generatePipes({int count = 5, double distance = 400}) {
    final rnd = Random();
    for (double i = 0 ; i < count ; i++) {
      _lastPipe = PipePair(position: Vector2((i+1) * distance, rnd.nextDouble() * 550 - 275));
      add(_lastPipe);
    }
  }
  
  void _removeOldPipes() {
    final pipes = children.whereType<PipePair>();
    final toRemove = max(pipes.length - 5, 0);
    pipes.take(toRemove).forEach((pipe) {
      pipe.removeFromParent();
    });
  }
  
  void _checkToStart() {
    if (bloc.state.currentPlayingState.isNone) {
      bloc.startPlaying();
    }
  }

}