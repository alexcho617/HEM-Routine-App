import 'dart:collection';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';

import '../tableCalendar/src/shared/utils.dart';

class EventController extends GetxController {
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Map<DateTime, List<Routine>> routines = {
    DateTime.now(): [Routine(title: 'ARoutine')]
  };

  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  void addEvent(DateTime date, CalendarEvent event) {
    List<CalendarEvent> eventList = [event];
    selectedEvents[date] = eventList;
  }

  //make a stream with events?
  int getRoutineCount() {
    return routines.length;
  }
}

class Routine {
  final String title;
  Routine({required this.title});

  String toString() => this.title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

final kEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      (index) => CalendarEvent(
          time: DateTime.now(), memo: 'Event $item | ${index + 1}'),
    )
}..addAll({
    kToday: [
      CalendarEvent(time: DateTime.now(), memo: 'calendarUtil event1'),
      CalendarEvent(time: DateTime.now(), memo: 'calendarUtil event2'),
    ],
  });

//alex
final kRoutines = LinkedHashMap<DateTime, List<Routine>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(kRoutineSource);

final kRoutineSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      (index) => Routine(title: 'Routine $item | ${index + 1}'),
    )
}..addAll({
    kToday: [Routine(title: 'Routine1')],
  });
//alex
