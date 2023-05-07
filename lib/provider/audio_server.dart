import 'package:audio_service/audio_service.dart';
import 'package:roger_music/provider/music_player.dart';

class AudioServer {
  late AudioHandler _audioHandler;

  static final AudioServer _instance = AudioServer._internal();
  AudioServer._internal();
  factory AudioServer() => _instance;

  AudioHandler get() => _audioHandler;

  void init() async {
    _audioHandler = await AudioService.init(
      builder: () => MusicPlayer(),
    );
  }
}
