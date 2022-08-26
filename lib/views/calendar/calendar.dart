// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/models/calendar_event.dart';
import 'package:hem_routine_app/models/calendar_routine.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/calendar/calendar_log.dart';
import 'package:hem_routine_app/views/calendar/new_calendar_event.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../tableCalendar/src/customization/calendar_builders.dart';
import '../../tableCalendar/src/customization/calendar_style.dart';
import '../../tableCalendar/src/shared/utils.dart';
import '../../tableCalendar/src/table_calendar.dart';
import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController controller = Get.put(CalendarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(builder: (_) {
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
                focusedDay: controller.focusedDate.value,
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(controller.selectedDay.value, date);
                },
                calendarFormat: CalendarFormat.month,
                headerStyle: kHeaderStyle,
                calendarStyle: CalendarStyle(outsideDaysVisible: false),
                //event loader is for marking
                eventLoader: (DateTime selectedDay) {
                  return _eventLoader(selectedDay);
                },
                onDaySelected: (DateTime selectDay, DateTime focusDay) {

                  controller.selectedDay.value = selectDay;
                  controller.focusedDate.value = focusDay;
                  controller.getCalendarLog();
                  controller.update();
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: false,
                    builder: (context) => CalendarLog(),
                  );
                },
              )),
          SizedBox(height: 50.h),
          plusSquareButton(
            () {
              controller.newEventTime = DateTime.now();
              Get.to(NewCalendarEvent());
              // kangmin(context, NewCalendarEvent());
            },
          ),
        ],
        // ),
      );
    });
  }

  List<CalendarEvent> _eventLoader(DateTime day) {
    DateTime parsedDay = parseDay(day);
    CalendarController controller = Get.find();
    List<CalendarEvent> listOfEvents;
    listOfEvents = controller.getEventsfromDay(parsedDay) ?? [];
    return listOfEvents;
  }

  //need refactoring
  Widget routineContainer(context, date, routines) {
    date = parseDay(date);
    if (controller.routineLibrary.isNotEmpty) {
      //within range, need to improve logic with some kind of function something like bool isWithinRange()
      //left border
      
      for (var i = 0; i < controller.routineLibrary.length; i++) {
        CalendarRoutine routine = controller.routineLibrary[i];
        
        if (routine.startDate == date) {
          return leftRoutineMarker(date, controller);
        }
        //right border
        if (routine.endDate == date) {
          return rightRoutineMarker(date, controller);
        }
        //inside rectangle border
        if (routine.startDate.isBefore(date) && routine.endDate.isAfter(date)) {
          return middleRoutineMarker(date, controller);
        }

        // else {
        //   return emptyRoutineMarker(date);
        // }
      }
    }
    return emptyRoutineMarker(date, controller);
  }
}

Widget emptyRoutineMarker(DateTime date, CalendarController controller) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: background),
      width: 57.0.w,
      height: 14.0.h,
      child: Text(
          style: TextStyle(color: primary),
          controller.getNumberOfEventsFromDay(date) ?? ''),
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}

Widget rightRoutineMarker(DateTime date, CalendarController controller) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          controller.getNumberOfEventsFromDay(date) ?? ''),
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

Widget middleRoutineMarker(DateTime date, CalendarController controller) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          controller.getNumberOfEventsFromDay(date) ?? ''),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: blue100),
      width: 57.0.w,
      height: 14.0.h,
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );
}

Widget leftRoutineMarker(DateTime date, CalendarController controller) {
  return OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text(
          style: TextStyle(color: primary),
          controller.getNumberOfEventsFromDay(date) ?? ''),
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
