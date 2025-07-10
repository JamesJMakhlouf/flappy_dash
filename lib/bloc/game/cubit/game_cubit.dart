import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flappy_dash/audio_helper.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {

  final AudioHelper _audioPlayer;

  GameCubit(this._audioPlayer) : super(GameState());

  void startPlaying() {
    _audioPlayer.playBackgroundAudio();
    emit(state.copyWith(
      currentPlayingState: PlayingState.playing,
      currentScore: 0
    ));
  }

  void increaseScore() {
    _audioPlayer.playScoreAudio();
    emit(state.copyWith(
      currentScore: state.currentScore + 1
    ));
  }

  void gameOver(){
    _audioPlayer.stopBackgroundAudio();
    emit(state.copyWith(
      currentPlayingState: PlayingState.gameOver
    ));
  }

  void restartGame() {
    emit(state.copyWith(
      currentPlayingState: PlayingState.none,
      currentScore: 0
    ));
  }
}
