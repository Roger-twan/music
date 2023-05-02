import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final _player = AudioPlayer();

  static final MusicPlayer _instance = MusicPlayer._internal();
  MusicPlayer._internal();
  factory MusicPlayer() => _instance;

  void init() {
    _player.playerStateStream.listen((PlayerState state) {
      // switch (state.processingState) {
      //   case ProcessingState.idle:

      //   case ProcessingState.loading: ...
      //   case ProcessingState.buffering: ...
      //   case ProcessingState.ready: ...
      //   case ProcessingState.completed: ...
      // }
    });
  }

  Future play(String url) async {
    await _player.setUrl(url);
    // final duration = await _player.setUrl(url);
    _player.play();
  }

  Future stop() async {
    await _player.pause();
  }

  Future resume() async {
    // await _player.resume();
  }

  Future seek(int ms) async {
    await _player.seek(Duration(microseconds: ms));
  }
}
