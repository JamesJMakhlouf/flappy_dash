import 'dart:ui';

import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = BlocProvider.of<GameCubit>(context);
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GAME OVER!',
                    style: TextStyle(
                      height: 0.75,
                      color: Colors.amber,
                      fontWeight: FontWeight.w900,
                      fontSize: 64,
                      shadows: [
                        for (double i = 0; i < 4; i += 0.25)
                          Shadow(color: Colors.black, offset: Offset(i, i)),
                        for (double i = 0; i < 2; i += 0.25)
                          Shadow(color: Colors.white, offset: Offset(-i, -i)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    'Score: ${state.currentScore}',
                    style: TextStyle(
                      height: 0.75,
                      color: Colors.amber,
                      fontSize: 40,
                      shadows: [
                        for (double i = 0; i < 3; i += 0.25)
                          Shadow(color: Colors.black, offset: Offset(i, i)),
                        for (double i = 0; i < 1.5; i += 0.25)
                          Shadow(color: Colors.white, offset: Offset(-i, -i)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      gameCubit.restartGame();
                    },
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
