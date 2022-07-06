import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dart:collection';

class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event(title: 'Event $item | ${index + 1}')))..addAll({
//     kToday: [
//       Event(title: 'Today\'s Event 1'),
//       Event(title: 'Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

CalendarStyle kCalendarStyle = CalendarStyle(

  isTodayHighlighted: true,
  markerSizeScale: 1.0,
  markersAlignment: Alignment.center,
  markerDecoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/characterIconYellow.png'),
    ),
    shape: BoxShape.rectangle,
    // color: Colors.blue,
  ),
  selectedDecoration: BoxDecoration(
    color: Colors.blue,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  selectedTextStyle: TextStyle(color: Colors.white),
  todayDecoration: BoxDecoration(
    color: Colors.purpleAccent,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  defaultDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  weekendDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
);

HeaderStyle kHeaderStyle = HeaderStyle(
  formatButtonVisible: false,
  titleCentered: true,
  formatButtonShowsNext: false,
  formatButtonDecoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(5.0),
  ),
  formatButtonTextStyle: TextStyle(
    color: Colors.white,
  ),
);

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
final kLastDay = DateTime.now();
