import 'package:flutter/material.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';
import 'dart:collection';

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
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

DateTime parseDay(DateTime before) {
  DateTime after = DateTime(before.year, before.month, before.day);
  return after;
}
// final kLastDay = DateTime.now();
