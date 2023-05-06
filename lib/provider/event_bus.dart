import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class SearchEvent {
  String keywords;

  SearchEvent(this.keywords);
}

class PlayEvent {
  bool? isPlaying;
  String? state; // loading, ready
  int? position;
  int? bufferedPosition;

  PlayEvent({
    this.isPlaying,
    this.state,
    this.position,
    this.bufferedPosition,
  });
}

class LikesSongUpdateEvent {
  bool? updated;

  LikesSongUpdateEvent(this.updated);
}
