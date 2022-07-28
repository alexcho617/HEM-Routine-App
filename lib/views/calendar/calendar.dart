// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/calendar/newCalendarEvent.dart';

import 'package:hem_routine_app/views/bottom_pop_up/routineLog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../tableCalendar/src/customization/calendar_builders.dart';
import '../../tableCalendar/src/customization/calendar_style.dart';
import '../../tableCalendar/src/shared/utils.dart';
import '../../tableCalendar/src/table_calendar.dart';
import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EventController controller = Get.find();

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    CalendarEvent event = CalendarEvent(time: date, color: primary);
    controller.addEvent(date, event);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TableCalendar<CalendarEvent>(
          calendarBuilders: CalendarBuilders(
            //this is acting like a singleMarkerbuilder. Need to change it as regular marker builder.
            routineMarkerBuilder: (context, date, routines) {
              return routineContainer;
            },
          ),
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

  Widget routineContainer = OverflowBox(
    alignment: Alignment.bottomCenter,
    child: Container(
      alignment: Alignment.center,
      child: Text('${controller.getRoutineCount()}'),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: blue200),
      width: 57.0.w,
      height: 14.0.h,
      // margin: const EdgeInsets.symmetric(horizontal: 10.5),
    ),
  );

  List<CalendarEvent> _eventLoader(DateTime day) {
    EventController controller = Get.find();
    List<CalendarEvent> list;
    list = controller.getEventsfromDay(day) ?? [];
    return list;
  }
}
