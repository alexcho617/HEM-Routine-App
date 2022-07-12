import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hem_routine_app/models/event.dart';

class EventController extends GetxController {
  Map<DateTime, List<UserEvent>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();

  List<dynamic>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  void addEvent(DateTime date, UserEvent event) {
    List<UserEvent> eventList = [event];
    selectedEvents[date] = eventList;
  }
  //make a stream with events?
}
