import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class SearchEvent {
  String keywords;

  SearchEvent(this.keywords);
}

enum OpenDrawerEvent {
  playlist,
  settings,
}

class PlayEvent {
  bool? isPlaying;
  int? duration;
  int? position;
  int? bufferedPosition;

  PlayEvent({
    this.isPlaying,
    this.duration,
    this.position,
    this.bufferedPosition,
  });
}
