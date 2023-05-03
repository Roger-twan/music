import 'package:just_audio/just_audio.dart';
import '../model/search_songs_model.dart';
import 'event_bus.dart';

class MusicPlayer {
  final _player = AudioPlayer();
  late SongModel _playingSong;

  static final MusicPlayer _instance = MusicPlayer._internal();
  MusicPlayer._internal();
  factory MusicPlayer() => _instance;

  void init() {
    _player.setLoopMode(LoopMode.one); //TODO: delete
    _player.playerStateStream.listen((PlayerState state) {
      eventBus.fire(PlayEvent(isPlaying: state.playing));
    });
    _player.positionStream.listen((Duration? duration) {
      eventBus.fire(PlayEvent(position: duration!.inMilliseconds));
    });
    _player.bufferedPositionStream.listen((Duration? duration) {
      eventBus.fire(PlayEvent(bufferedPosition: duration!.inMilliseconds));
    });
  }

  Future play([SongModel? song]) async {
    if (song != null) {
      _playingSong = song;
      final duration = await _player.setUrl(song.url!);
      eventBus.fire(PlayEvent(duration: duration!.inMilliseconds));
    }
    _player.play();
  }

  Future pause() async {
    await _player.pause();
  }

  Future seek(int ms) async {
    await _player.seek(Duration(milliseconds: ms));
  }

  SongModel getPlayingSong() {
    return _playingSong;
  }

  void setLyric(String lyr) {
    _playingSong.lyric = lyr;
  }
}
