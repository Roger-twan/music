import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import '../model/songs_model.dart';
import 'likes_song.dart';
import 'event_bus.dart';
import 'preferences.dart';

class MusicPlayer extends BaseAudioHandler {
  final _player = AudioPlayer();
  final _likesSong = LikesSong();
  List<SongModel?> _likesSongList = [];
  SongModel? _playingSong;
  int? _playingSongIndex;
  String? _loopMode; // all,one,shuffle

  static final MusicPlayer _instance = MusicPlayer._internal();
  factory MusicPlayer() => _instance;
  MusicPlayer._internal();

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
        AudioService.position.listen((Duration position) {
          if (_playingSong != null &&
              _playingSong?.duration != null &&
              position.inMilliseconds + 150 >= _playingSong!.duration!) {
            playNext();
          }
          eventBus.fire(PlayEvent(position: position.inMilliseconds));
        });
        eventBus.fire(PlayEvent(state: 'ready'));
      }
    });
    _player.positionStream.listen((Duration? duration) {
      // only be triggered when pause
      if (duration != null && duration.inSeconds != 0) {
        playbackState
            .add(playbackState.value.copyWith(updatePosition: duration));
      }
    });
    _player.bufferedPositionStream.listen((Duration? duration) {
      eventBus.fire(PlayEvent(bufferedPosition: duration!.inMilliseconds));
    });
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: playing,
      ));
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

  @override
  Future play([SongModel? song]) async {
    if (song != null) {
      _playingSong = song;
      final duration = await _player.setUrl(song.url!);
      _playingSong?.duration = duration == null || duration.inMilliseconds == 0
          ? song.duration
          : duration.inMilliseconds;
      _playingSongIndex = _likesSongList
          .indexWhere((SongModel? likedSong) => likedSong?.id == song.id);

      mediaItem.add(MediaItem(
          id: song.id.toString(),
          title: song.name,
          artist: song.artist,
          artUri: Uri.parse(
              'https://raw.githubusercontent.com/roger-twan/music/main/lib/assets/logo.png'),
          duration: Duration(milliseconds: _playingSong!.duration!)));

      playbackState
          .add(playbackState.value.copyWith(updatePosition: Duration.zero));
    }

    _player.play();
  }

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() {
    playNext();
    return Future.value(null);
  }

  @override
  Future<void> skipToPrevious() {
    playPrevious();
    return Future.value(null);
  }

  void playNext() {
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

  Future playPrevious() async {
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
