// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/models/calendarRoutine.dart';
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
                  // print(focusDay);
                  // print(
                  //     controller.eventsLibrary[parseDay(focusDay)].toString());

                  controller.selectedDay.value = selectDay;
                  controller.focusedDate.value = focusDay;
                  controller.update();
                },
              )),
          SizedBox(height: 50.h),
          plusSquareButton(
            () {
              Get.to(NewCalendarEvent());

              //   if (controller.selectedDay.value.day == DateTime.now().day) {
              //     controller.newEventTime.value = DateTime.now();
              //   } else {
              //     controller.newEventTime.value = controller.selectedDay.value;
              //   }
              //   Get.to(NewCalendarEvent());
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         controller.printAllEvents();
          //       },
          //       child: Text('PrintEvents'),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         controller.printAllRoutines();
          //       },
          //       child: Text('PrintRoutines'),
          //     ),
          //   ],
          // ),
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
      // print(date.toString());
      for (var i = 0; i < controller.routineLibrary.length; i++) {
        CalendarRoutine routine = controller.routineLibrary[i];
        // print('length' + controller.routines.length.toString());
        // print('Printing Routine -----'+routine.toString());
        if (routine.startDate == date) {
          // print('start');
          return leftRoutineMarker(date);
        }
        //right border
        if (routine.endDate == date) {
          // print('end');
          return rightRoutineMarker(date);
        }
        //inside rectangle border
        if (routine.startDate.isBefore(date) && routine.endDate.isAfter(date)) {
          // print(routine.startDate);
          // print(routine.endDate);

          // print('middle');
          return middleRoutineMarker(date);
        }

        // else {
        //   return emptyRoutineMarker(date);
        // }
      }
    }
    return emptyRoutineMarker(date);
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
