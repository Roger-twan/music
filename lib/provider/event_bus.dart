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
