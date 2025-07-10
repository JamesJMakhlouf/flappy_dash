part of 'game_cubit.dart';

class GameState extends Equatable {

  final int currentScore;
  final PlayingState currentPlayingState;

  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.none,
  });

  @override
  List<Object?> get props => [
    currentScore,
    currentPlayingState
  ];

  GameState copyWith({
    int? currentScore, 
    PlayingState? currentPlayingState
  }) => 
    GameState(
      currentScore: currentScore ?? this.currentScore,
      currentPlayingState: currentPlayingState ?? this.currentPlayingState
    );
}

enum PlayingState{
  none, 
  playing, 
  paused, 
  gameOver;

  bool get isPlaying => this == PlayingState.playing;
  bool get isGameOver => this == PlayingState.gameOver;
  bool get isPaused => this == PlayingState.paused;
  bool get isNone => this == PlayingState.none;
}