import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class SearchEvent {
  String keywords;

  SearchEvent(this.keywords);
}

class PlayEvent {
  bool? isPlaying;
  bool? isActive;
  int? position;
  int? bufferedPosition;

  PlayEvent({
    this.isPlaying,
    this.isActive,
    this.position,
    this.bufferedPosition,
  });
}
