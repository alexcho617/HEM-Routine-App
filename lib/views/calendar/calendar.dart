// ignore_for_file: prefer_const_constructors

/*
1.달력 자체는 이번 달 그리고 다음달까지 보여주는걸로 한다. 그 이유는 루틴을 설정을 최대 14일까지 할 수 있기때문이다.
하지만 배변 기록을 추가 할 때는 현재 시간을 가져와서 미래시간엔 못하게 막는다.

2.tableCalendar에서 레인지 이벤트 설정이 잘 안되고 있다.루틴을 레인지 이벤트로 취급해서 달력에 짝대기가 쭉 그어져야하는게 목표다.
우회하는 방법으로는 하루 하루 이벤트를 추가해서 아이콘을 점에서 막대기 형ㅎ태로 바꾸어 이어서 보이게 하는 효과를 연출 할 수 있다.

2.1 아이콘을 변경하려면 customCalendar 를 만들어야한다. CalendarBuilder를 사용하며 MarkerBuilder로 이벤트 표시해야함.

3. When the event occurs, set a single event marker with the character image, however only one marker is allowed in the calendar. Which is a problem for adding a routine. If routine will be added as marker, then there must be a different way to show marker which is very unnatural.
use a single marker builder for dynamic marking https://github.com/aleksanderwozniak/table_calendar/issues/64#issuecomment-521781914


Perhaps, find a option to display some kind of background color for the routined dates. This can be done by using a different calendarProperty to certain dates?
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/calendar/newCalendarEvent.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';

import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    EventController controller = Get.find();
    DateTime date = DateTime(2022, 7, 5);
    CalendarEvent event = CalendarEvent(time: date, color: primary);
    controller.addEvent(date, event);

    // return Scaffold(
    //   body:
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TableCalendar<CalendarEvent>(
          calendarBuilders: CalendarBuilders(
            //this is acting like a singleMarkerbuilder. Need to change it as regular marker builder.
            routineMarkerBuilder: (context, date, routines) {
              // event.memo
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
          calendarStyle: CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: false,
          ),
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

        // TableCalendar(
        //   calendarBuilders: CalendarBuilders(
        //     singleMarkerBuilder: (context, date, event) {
        //       // event.memo
        //       return Container(
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle, color: Colors.redAccent),
        //         width: 7.0,
        //         height: 7.0,
        //         margin: const EdgeInsets.symmetric(horizontal: 1.5),
        //       );
        //     },
        //   ),
        //   focusedDay: controller.selectedDay,
        //   firstDay: DateTime(2022),
        //   lastDay: DateTime.now(),
        //   calendarFormat: format,
        //   startingDayOfWeek: StartingDayOfWeek.sunday,
        //   daysOfWeekVisible: true,
        //   //Day Changed
        //   onDaySelected: (DateTime selectDay, DateTime focusDay) {
        //     print(focusDay);
        //     setState(() {
        //       controller.selectedDay = selectDay;
        //       controller.focusedDate = focusDay;
        //     });
        //   },

        //   selectedDayPredicate: (DateTime date) {
        //     return isSameDay(controller.selectedDay, date);
        //   },
        //   eventLoader: _eventLoader,
        //   calendarStyle: kCalendarStyle,
        //   headerStyle: kHeaderStyle,
        // ),

        ..._eventLoader(controller.selectedDay).map(
          (CalendarEvent event) => ListTile(
            title: Text(
              event.memo.toString(),
            ),
          ),
        ),
        SizedBox(
          height: 20.0.h,
        ),
        PlusSquareButton(
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
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: blue200),
      width: 57.0.w,
      height: 7.0.h,
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
