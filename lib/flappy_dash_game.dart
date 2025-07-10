import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/components/root_component.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flappy_dash/service_locator.dart';
import 'package:flutter/services.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardHandler, HasCollisionDetection {

  final GameCubit gameCubit;

  FlappyDashGame(this.gameCubit): super(
    world: FlappyDashWorld(),
    camera: CameraComponent.withFixedResolution(
      width: 640, 
      height: 1200,
    ),
  );

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent && keysPressed.contains(LogicalKeyboardKey.space)) {
      world.onSpaceDown();
    }
    return super.onKeyEvent(event, keysPressed);
  }

}

class FlappyDashWorld extends World with HasGameReference<FlappyDashGame>, TapCallbacks {

  late FlappyDashRootComponent _rootComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await getIt.get<AudioHelper>().initialize();
    add(
      FlameBlocProvider<GameCubit, GameState>(
        create: () => game.gameCubit,
        children: [
          _rootComponent = FlappyDashRootComponent()
        ]
      )
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _rootComponent.onTapDownOronSpaceDown();
  }

  void onSpaceDown() {
    _rootComponent.onTapDownOronSpaceDown();
  }

}