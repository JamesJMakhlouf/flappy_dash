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
    parallax = await game.loadParallax(
      [
        ParallaxImageData('assets/images/background/_11_background.png'),
        ParallaxImageData('assets/images/background/_10_distant_clouds.png'),
        ParallaxImageData('assets/images/background/_09_distant_clouds1.png'),
        ParallaxImageData('assets/images/background/_08_clouds.png'),
        ParallaxImageData('assets/images/background/_07_huge_clouds.png'),
        ParallaxImageData('assets/images/background/_06_hill2.png'),
        ParallaxImageData('assets/images/background/_05_hill1.png'),
        ParallaxImageData('assets/images/background/_04_bushes.png'),
        ParallaxImageData('assets/images/background/_03_distant_trees.png'),
        ParallaxImageData('assets/images/background/_02_trees and bushes.png'),
        ParallaxImageData('assets/images/background/_01_ground.png'),
      ],
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
      // defaassets/images/ult:
    }
  }
}