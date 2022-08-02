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
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCalendar<CalendarEvent>(
            calendarBuilders:
                CalendarBuilders(routineMarkerBuilder: routineContainer),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            focusedDay: controller.focusedDate,
            selectedDayPredicate: (DateTime date) {
              return isSameDay(controller.selectedDay, date);
            },
            calendarFormat: CalendarFormat.month,
            headerStyle: kHeaderStyle,
            calendarStyle: CalendarStyle(), //using default calendar style
            //event loader is for marking
            eventLoader: (DateTime selectedDay) {
              return _eventLoader(selectedDay);
            },
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              print(focusDay);
              print(controller.selectedEvents[focusDay].toString());
              setState(() {
                controller.selectedDay = selectDay;
                controller.focusedDate = focusDay;
              });
            },
          ),
        ),
        SizedBox(height: 50.h),
        plusSquareButton(
          () {
            if (controller.selectedDay.day == DateTime.now().day) {
              controller.newEventTime.value = DateTime.now();
            }
            else {
              controller.newEventTime.value = controller.selectedDay;
            }
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
