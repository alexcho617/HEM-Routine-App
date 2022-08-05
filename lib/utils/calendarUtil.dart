// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

String parseDayToString(DateTime before) {
  String weekday;
  switch (before.weekday) {
    case 1:
      weekday = '월';
      break;
    case 2:
      weekday = '화';
      break;
    case 3:
      weekday = '수';
      break;
    case 4:
      weekday = '목';
      break;
    case 5:
      weekday = '금';
      break;
    case 6:
      weekday = '토';
      break;
    case 7:
      weekday = '일';
      break;

    default:
      weekday = '월';
  }
  return "${before.year}-${before.month}-${before.day} ($weekday)";
}

String parseColorCode(String code) {
  String color = '';
  switch (code) {
    case '0':
      color = '회색';
      break;
    case '1':
      color = '붉은색';
      break;
    case '2':
      color = '초록색';
      break;
    case '3':
      color = '노란색';
      break;
    case '4':
      color = '갈색';
      break;
    case '5':
      color = '고동색';
      break;
    case '6':
      color = '흑색';
      break;
    default:
      '';
  }
  return color;
}

String parseTypeCode(String code) {
  String type = '';
  switch (code) {
    case '0':
      type = '물변';
      break;
    case '1':
      type = '진흙변';
      break;
    case '2':
      type = '무른변';
      break;
    case '3':
      type = '매끈변';
      break;
    case '4':
      type = '금간변';
      break;
    case '5':
      type = '딱딱변';
      break;
    case '6':
      type = '토끼변';
      break;
    default:
      '매끈변';
  }
  return type;
}

String parseHardnessCode(String code) {
  String hardness = '';
  switch (code) {
    case '0':
      hardness = '많이 불편';
      break;
    case '1':
      hardness = '불편';
      break;
    case '2':
      hardness = '편함';
      break;
    case '3':
      hardness = '매우 편함';
      break;
    default:
      '';
  }
  return hardness;
}

String parseTime(DateTime date) {
  String dateString = '';

  dateString = DateFormat('a hh:mm', 'ko_KR').format(date);
  return dateString;
}
