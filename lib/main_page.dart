import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/widgets/game_over_widget.dart';
import 'package:flappy_dash/widgets/tap_to_play.dart';
import 'package:flappy_dash/widgets/top_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;

  PlayingState? _latestState;

  @override
  void initState() {
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currentPlayingState.isNone && _latestState == PlayingState.gameOver) {
          _flappyDashGame = FlappyDashGame(gameCubit);
        }
        _latestState = state.currentPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyDashGame),
              const TopScore(),
              if (state.currentPlayingState.isGameOver)
                const GameOverWidget(),
              if (state.currentPlayingState.isNone)
                const TapToPlay()
            ],
          ),
        );
      },
    );
  }
}