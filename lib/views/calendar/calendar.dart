// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/calendar/newCalendarEvent.dart';

import '../../tableCalendar/src/customization/calendar_builders.dart';
import '../../tableCalendar/src/customization/calendar_style.dart';
import '../../tableCalendar/src/shared/utils.dart';
import '../../tableCalendar/src/table_calendar.dart';
import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CalendarController controller = Get.find();

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TableCalendar<CalendarEvent>(
          calendarBuilders: CalendarBuilders(
              //this is acting like a singleMarkerbuilder. Need to change it as regular marker builder.
              routineMarkerBuilder: routineContainer),
          firstDay: kFirstDay,
          lastDay: kLastDay,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          focusedDay: controller.focusedDate,
          selectedDayPredicate: (DateTime date) {
            return isSameDay(controller.selectedDay, date);
          },
          calendarFormat: CalendarFormat.month,
          headerStyle: kHeaderStyle,
          // TODO 1 : calendarStyle: returnCalendarStyleWithCustomIcon
          calendarStyle: CalendarStyle(), //using default calendar style
          //need event loader for marking
          eventLoader: (DateTime selectedDay) {
            return _eventLoader(selectedDay);
          },
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            print(focusDay);
            setState(() {
              controller.selectedDay = selectDay;
              controller.focusedDate = focusDay;
            });
          },
        ),
        plusSquareButton(
          () {
            Get.to(NewCalendarEvent());
          },
        ),
      ],
      // ),
    );
  }

  //need refactoring
  Widget routineContainer(context, date, routines) {
    if (controller.routines.isNotEmpty) {
      //within range, need to improve logic with some kind of function something like bool isWithinRange()
      //left border
      if (controller.routines[0].startDate == date) {
        return leftRoutineMarker(date);
      }
      //right border
      if (controller.routines[0].endDate == date) {
        return rightRoutineMarker(date);
      }
      //inside rectangle border
      if (controller.routines[0].startDate.isBefore(date) &&
          controller.routines[0].endDate.isAfter(date)) {
        return middleRoutineMarker(date);
      } else {
        return emptyRoutineMarker(date);
      }
    } else {
      return emptyRoutineMarker(date);
    }
  }

  List<CalendarEvent> _eventLoader(DateTime day) {
    CalendarController controller = Get.find();
    List<CalendarEvent> list;
    list = controller.getEventsfromDay(day) ?? [];
    return list;
  }
}

Widget emptyRoutineMarker(DateTime date) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: background),
      width: 57.0.w,
      height: 14.0.h,
      child: Text(
          style: TextStyle(color: primary),
          '${controller.getNumberOfEventsFromDay(date) ?? ''}'),
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}

Widget rightRoutineMarker(DateTime date) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          '${controller.getNumberOfEventsFromDay(date) ?? ''}'),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: blue100),
      width: 57.0.w,
      height: 14.0.h,
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}

Widget middleRoutineMarker(DateTime date) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          '${controller.getNumberOfEventsFromDay(date) ?? ''}'),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: blue100),
      width: 57.0.w,
      height: 14.0.h,
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}

Widget leftRoutineMarker(DateTime date) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          '${controller.getNumberOfEventsFromDay(date) ?? ''}'),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: blue100),
      width: 57.0.w,
      height: 14.0.h,
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}
