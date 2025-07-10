import 'package:flame_audio/flame_audio.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioHelper {

  AudioPlayer? _bgmPlayer;

  Future<void> initialize() async {
    await FlameAudio.audioCache.loadAll([
      'background.mp3',
      'score.mp3',
    ]);
  }

  Future<void> playBackgroundAudio() async {
    _bgmPlayer = await FlameAudio.loopLongAudio('background.mp3');
  }

  void stopBackgroundAudio() {
    if (_bgmPlayer != null) {
      _bgmPlayer!.stop();
      _bgmPlayer = null;
    }
  }

  void playScoreAudio() {
    FlameAudio.play('score.mp3');
  }
}




// import 'package:flutter_soloud/flutter_soloud.dart';

// class AudioPlayer {

//   late SoLoud _soLoud;
//   late AudioSource _backgroundSource;
//   late AudioSource _scoreSource;
//   SoundHandle? _playingBackground;

//   Future<void> initialize() async {
//     _soLoud = SoLoud.instance;
//     if (!_soLoud.isInitialized) {
//       await _soLoud.init();
//     } 
//     _backgroundSource = await _soLoud.loadAsset('assets/audio/background.mp3');
//     _scoreSource = await _soLoud.loadAsset('assets/audio/score.mp3');
//   }

//   void playBackgroundAudio() async {
//     _playingBackground = await _soLoud.play(_backgroundSource);
//     _soLoud.setProtectVoice(_playingBackground!, true);
//   }

//   void stopBackgroundAudio() {
//     if (_playingBackground == null) {
//       return;
//     }
//     _soLoud.fadeVolume(_playingBackground!, 0, const Duration(milliseconds: 500));
//   }

//   void playScoreAudio() async {
//     await _soLoud.play(_scoreSource);
//   }

// }