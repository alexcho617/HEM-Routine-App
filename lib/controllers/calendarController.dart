// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/models/calendarRoutine.dart';


class EventController extends GetxController {
  //initialize selected and focused Date
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();

  //where events are stored
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};

  //returns list of events from a given date
  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  //add a new event to selected events
  void addEvent(DateTime date, CalendarEvent event) {
    //if event exists add to existing list
    if (selectedEvents[date] != null) {
      selectedEvents[date]!.add(event);
    }
    //else create new list
    else {
      List<CalendarEvent> eventList = [event];
      selectedEvents[date] = eventList;
    }
  }

  //where routines are stored, not sure about the date time mapping.
  List<CalendarRoutine> routines = [CalendarRoutine(name: 'myCalendarRoutine')];

  int getRoutineCount() {
    return routines.length;
  }
}
