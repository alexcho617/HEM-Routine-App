// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'dart:math';

//this is used in calendar_core builder
class CalendarPage extends StatelessWidget {
  final Widget Function(BuildContext context, DateTime day)? dowBuilder;
  final Widget Function(BuildContext context, DateTime day) dayBuilder;
  final List<DateTime> visibleDays;
  final Decoration? dowDecoration;
  final Decoration? rowDecoration;
  final TableBorder? tableBorder;
  final bool dowVisible;

  const CalendarPage({
    Key? key,
    required this.visibleDays,
    this.dowBuilder,
    required this.dayBuilder,
    this.dowDecoration,
    this.rowDecoration,
    this.tableBorder,
    this.dowVisible = true,
  })  : assert(!dowVisible || dowBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: tableBorder,
      children: [
        if (dowVisible) _buildDaysOfWeek(context),
        ..._buildCalendarDays(context),
      ],
    );
  }

  TableRow _buildDaysOfWeek(BuildContext context) {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
        (index) => dowBuilder!(context, visibleDays[index]),
      ).toList(),
    );
  }

  List<TableRow> _buildCalendarDays(BuildContext context) {
    final rowAmount = visibleDays.length ~/ 7;

    //이벤트 정보 가져오고 현재 그리는 정보와 비교
    return List.generate(rowAmount, (index) => index * 7)
        .map((index) => TableRow(
              decoration: rowDecoration,
              children: List.generate(
                7,
                (id) => Stack(alignment: Alignment.center, children: [
                  //if event exist
                  dayBuilder(context, visibleDays[index + id]),
                  //각 날짜와 리스트안에 있는 이벤트와 비교해서 출력해야할듯
                  // controller.markerColor.value == 'yellow'
                  //stack works so just have to map each index with events

                  // index % 2 == 0
                  //     ? Image.asset('assets/characterIconYellow.png')
                  //     : Image.asset('assets/characterIconRed.png')

                  //else
                  // dayBuilder(context, visibleDays[index + id]),
                ]),
              ),
            ))
        .toList();
  }
}



//  List<TableRow> _buildCalendarDays(BuildContext context) {
//     EventController controller = Get.find();
//     final rowAmount = visibleDays.length ~/ 7;
//     return List.generate(rowAmount, (index) => index * 7)
//         .map((index) => TableRow(
//               decoration: rowDecoration,
//               children: List.generate(
//                 7,
//                 (id) => Stack(
//                   children: [
//                     dayBuilder(context, visibleDays[index + id]),
//                     Obx(
//                       () => Text(controller.markerColor.value),
//                     ),
//                   ],
//                 ),
//               ),
//             ))
//         .toList();
//   }