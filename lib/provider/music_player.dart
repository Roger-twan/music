import 'dart:math';
import 'package:just_audio/just_audio.dart';
import '../model/songs_model.dart';
import 'likes_song.dart';
import 'event_bus.dart';
import 'preferences.dart';

class MusicPlayer {
  final _player = AudioPlayer();
  final _likesSong = LikesSong();
  List<SongModel?> _likesSongList = [];
  SongModel? _playingSong;
  int? _playingSongIndex;
  String? _loopMode; // all,one,shuffle

  static final MusicPlayer _instance = MusicPlayer._internal();
  MusicPlayer._internal();
  factory MusicPlayer() => _instance;

  void init() {
    setLoopMode();
    _intListener();
    _setLikesSongList();

    eventBus.on<LikesSongUpdateEvent>().listen((event) {
      if (event.updated != null && event.updated!) {
        _setLikesSongList();
      }
    });
  }

  void _setLikesSongList() {
    _likesSongList = _likesSong.getList().reversed.toList();
  }

  void _intListener() {
    _player.playerStateStream.listen((PlayerState state) {
      eventBus.fire(PlayEvent(isPlaying: state.playing));
    });
    _player.processingStateStream.listen((ProcessingState state) async {
      if (state == ProcessingState.buffering) {
        eventBus.fire(PlayEvent(state: 'loading'));
      } else if (state == ProcessingState.ready) {
        eventBus.fire(PlayEvent(state: 'ready'));
      }
    });
    _player.positionStream.listen((Duration? duration) {
      if (_playingSong != null &&
          _playingSong?.duration != null &&
          duration!.inMilliseconds + 150 >= _playingSong!.duration!) {
        next();
      }
      eventBus.fire(PlayEvent(position: duration!.inMilliseconds));
    });
    _player.bufferedPositionStream.listen((Duration? duration) {
      eventBus.fire(PlayEvent(bufferedPosition: duration!.inMilliseconds));
    });
  }

  SongModel? getPlayingSong() => _playingSong;
  String? getLoopMode() => _loopMode;

  void setLoopMode([String? mode]) async {
    final preferences = Preferences().get();
    if (mode == null) {
      _loopMode = preferences?.getString('loopMode') ?? 'all';
    } else {
      _loopMode = mode;
      await preferences?.setString('loopMode', mode);
    }
  }

  Future play([SongModel? song]) async {
    if (song != null) {
      _playingSong = song;
      final duration = await _player.setUrl(song.url!);
      _playingSong?.duration = duration?.inMilliseconds ?? song.duration;
      _playingSongIndex = _likesSongList
          .indexWhere((SongModel? likedSong) => likedSong?.id == song.id);
    }
    _player.play();
  }

  Future pause() async {
    await _player.pause();
  }

  Future seek(int ms) async {
    await _player.seek(Duration(milliseconds: ms));
  }

  void next() {
    int nextPlayIndex = 0;
    if (_playingSongIndex == -1) {
      nextPlayIndex = 0;
    } else {
      switch (_loopMode) {
        case 'all':
          nextPlayIndex = _playingSongIndex! + 1 >= _likesSongList.length
              ? 0
              : _playingSongIndex! + 1;
          break;
        case 'one':
          nextPlayIndex = _playingSongIndex!;
          break;
        case 'shuffle':
          nextPlayIndex = Random().nextInt(_likesSongList.length);
          break;
        default:
          break;
      }
    }

    play(_likesSongList[nextPlayIndex]);
  }

  Future previous() async {
    int previousPlayIndex = 0;
    if (_playingSongIndex == -1) {
      previousPlayIndex = 0;
    } else {
      switch (_loopMode) {
        case 'all':
          previousPlayIndex = _playingSongIndex! - 1 >= 0
              ? _playingSongIndex! - 1
              : _likesSongList.length - 1;
          break;
        case 'one':
          previousPlayIndex = _playingSongIndex!;
          break;
        case 'shuffle':
          previousPlayIndex = Random().nextInt(_likesSongList.length);
          break;
        default:
          break;
      }
    }

    play(_likesSongList[previousPlayIndex]);
  }

  void setLyric(String lyr) {
    _playingSong?.lyric = lyr;
  }
}
