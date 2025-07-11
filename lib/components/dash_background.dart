import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

class DashBackground extends ParallaxComponent<FlappyDashGame> with FlameBlocReader<GameCubit, GameState> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    List<ParallaxData> dataList;
    try {
    dataList = [
      // ParallaxImageData('background/_11_background.png'),
      // ParallaxImageData('background/_10_distant_clouds.png'),
      // ParallaxImageData('background/_09_distant_clouds1.png'),
      // ParallaxImageData('background/_08_clouds.png'),
      // ParallaxImageData('background/_07_huge_clouds.png'),
      // ParallaxImageData('background/_06_hill2.png'),
      // ParallaxImageData('background/_05_hill1.png'),
      // ParallaxImageData('background/_04_bushes.png'),
      // ParallaxImageData('background/_03_distant_trees.png'),
      // ParallaxImageData('background/_02_trees_and_bushes.png'),
      // ParallaxImageData('background/_01_ground.png'),
    ];
    } catch (e) {
      dataList = [];
    }
    parallax = await game.loadParallax(
      dataList,
      baseVelocity: Vector2(1, 0),
      velocityMultiplierDelta: Vector2(1.5, 0)
    );
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
      case PlayingState.playing:
        super.update(dt);
        break;
      case PlayingState.gameOver:
      case PlayingState.paused:
        break;
      // default:
    }
  }
}