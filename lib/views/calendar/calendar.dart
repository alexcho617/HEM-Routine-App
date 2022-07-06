/*
1.달력 자체는 이번 달 그리고 다음달까지 보여주는걸로 한다. 그 이유는 루틴을 설정을 최대 14일까지 할 수 있기때문이다.
하지만 배변 기록을 추가 할 때는 현재 시간을 가져와서 미래시간엔 못하게 막는다.

2.tableCalendar에서 레인지 이벤트 설정이 잘 안되고 있다.루틴을 레인지 이벤트로 취급해서 달력에 짝대기가 쭉 그어져야하는게 목표다.
우회하는 방법으로는 하루 하루 이벤트를 추가해서 아이콘을 점에서 막대기 형ㅎ태로 바꾸어 이어서 보이게 하는 효과를 연출 할 수 있다.

2.1 아이콘을 변경하려면 customCalendar 를 만들어야한다. CalendarBuilder를 사용하며 MarkerBuilder로 이벤트 표시해야함.

3. When the event occurs, set a single event markr with the character image, however only one marker is allowed in the calendar. Which is a problem for adding a routine. If routine will be added as marker, then there must be a different way to show marker which is very unnatural.

Perhaps, find a option to display some kind of background color for the routined dates. This can be done by using a different calendarProperty to certain dates?
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';
import 'package:hem_routine_app/views/calendar/newCalendarEvent.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    EventController controller = Get.find();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TableCalendar(
            focusedDay: controller.selectedDay,
            firstDay: DateTime(2022),
            lastDay: DateTime.now(),
            calendarFormat: format,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                controller.selectedDay = selectDay;
                controller.focusedDate = focusDay;
              });
            },

            selectedDayPredicate: (DateTime date) {
              return isSameDay(controller.selectedDay, date);
            },
            eventLoader: _eventLoader,
            calendarStyle: kCalendarStyle,
            headerStyle: kHeaderStyle,
          ),

          //event loading
          // ..._eventLoader(controller.selectedDay).map(
          //   (Event event) => ListTile(
          //     title: Text(
          //       event.title,
          //     ),
          //   ),
          // ),
          // PlusSquareButton(onAddEventButtonPressed),
          PlusSquareButton(() {
            Get.to(NewCalendarEvent());
          }),
        ],
      ),
    );
  }

  List<dynamic> _eventLoader(DateTime date) {
    EventController controller = Get.find();
    List<dynamic> list;
    list = controller.getEventsfromDay(date) ?? [];
    return list;
  }
}