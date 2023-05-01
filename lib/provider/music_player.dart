import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  final _plyer = AudioPlayer();

  static final MusicPlayer _instance = MusicPlayer._internal();
  MusicPlayer._internal();
  factory MusicPlayer() => _instance;

  AudioPlayer? get() {
    return _plyer;
  }
}
