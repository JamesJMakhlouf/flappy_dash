import 'package:flappy_dash/bloc/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopScore extends StatelessWidget {
  const TopScore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                state.currentScore.toString(),
                style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.w900,
                color: Colors.amber,
                shadows: [
                  for (double i = 0; i < 5; i += 0.25) 
                    Shadow(
                      color: Colors.black,
                      offset: Offset(i, i)
                    ),
                  for (double i = 0; i < 2.5; i += 0.25) 
                    Shadow(
                      color: Colors.white,
                      offset: Offset(-i, -i)
                    ),
                ]
              )
            ),
          ),
        );
      },
    );
  }
}