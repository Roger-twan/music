import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/search_songs_model.dart';
import 'event_bus.dart';
import 'preferences.dart';

class MusicPlayer {
  final _player = AudioPlayer();
  late SongModel _playingSong;
  late String _loopShuffleMode; // all,one,shuffle

  static final MusicPlayer _instance = MusicPlayer._internal();
  MusicPlayer._internal();
  factory MusicPlayer() => _instance;

  void init() {
    setLoopShuffleMode();
    _intListener();
  }

  void setLoopShuffleMode([String? mode]) async {
    final SharedPreferences? preferences = Preferences().get();
    if (mode == null) {
      _loopShuffleMode = preferences?.getString('loopShuffleMode') ?? 'all';
    } else {
      _loopShuffleMode = mode;
      await preferences?.setString('loopShuffleMode', mode);
    }

    switch (_loopShuffleMode) {
      case 'all':
        _player.setLoopMode(LoopMode.all);
        _player.setShuffleModeEnabled(false);
        break;
      case 'one':
        _player.setLoopMode(LoopMode.one);
        break;
      case 'shuffle':
        _player.setLoopMode(LoopMode.all);
        _player.setShuffleModeEnabled(true);
        break;
      default:
        break;
    }
  }

  void _intListener() {
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

  SongModel getPlayingSong() => _playingSong;
  String getLoopShuffleMode() => _loopShuffleMode;

  Future play([SongModel? song]) async {
    if (song != null) {
      _playingSong = song;
      final duration = await _player.setUrl(song.url!);
      _playingSong.duration = duration!.inMilliseconds;
      eventBus.fire(PlayEvent(isActive: true));
    }
    _player.play();
  }

  Future pause() async {
    await _player.pause();
  }

  Future seek(int ms) async {
    await _player.seek(Duration(milliseconds: ms));
  }

  void setLyric(String lyr) {
    _playingSong.lyric = lyr;
  }
}
