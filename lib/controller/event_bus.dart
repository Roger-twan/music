import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class SearchEvent {
  String keyword;

  SearchEvent(this.keyword);
}
