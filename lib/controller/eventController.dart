import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';

class EventController extends GetxController {
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();

  List<dynamic>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  void addEvent(DateTime date, CalendarEvent event) {
    List<CalendarEvent> eventList = [event];
    selectedEvents[date] = eventList;
  }
  //make a stream with events?
}
