// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/models/calendarRoutine.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'loginService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    eventsLibrary = await fetchAllEvents();
    update();
  }

  LoginService loginService = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //initialize selected and focused Date
  //DateFormat('t').format(DateTime.now());
  var selectedDay = DateTime.now().obs;
  var focusedDate = DateTime.now().obs;
  DateTime newEventTime = DateTime.now();

  //where events are stored, map of day to events
  RxMap eventsLibrary = {}.obs;
  // Map<DateTime, List<CalendarEvent>> selectedEvents = {};

  //returns list of events from a given date
  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return eventsLibrary[date];
  }

  int? getNumberOfEventsFromDay(DateTime? date) {
    int? num = eventsLibrary[date]?.length;
    if (num != null && num > 1) {
      return num;
    } else {
      return null;
    }
  }

  void printAllEvents() {
    print('---------PRINTING ALL EVENTS----------');
    var keys = eventsLibrary.keys;

    for (var key in keys) {
      print('Date : $key');
      List events = eventsLibrary[key];
      for (var event in events) {
        print(event.toString());
      }
    }
    print('---------END OF ALL EVENTS----------');
  }

  //add a new event to selected events
  // int addEvent(CalendarEvent event) {
  //   int flag = 0;
  //   //TODO mapping is not working properly. Its mapping to old event.
  //   //if event exists add to existing list
  //   if (selectedEvents[newEventTime.value] != null) {
  //     selectedEvents[newEventTime.value]!.add(event);
  //     flag = 1;
  //   }
  //   //else create new list
  //   else {
  //     List<CalendarEvent> eventList = [event];
  //     selectedEvents[newEventTime.value] = eventList;
  //     flag = 1;
  //   }
  //   if (flag == 1) {
  //     print(selectedEvents[newEventTime.value].toString());
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }

  //where routines are stored, not sure about the date time mapping.
  //List<CalendarRoutine> routines = [];
  //TODO Make multiple routines and fetch from server
  List<CalendarRoutine> routines = [
    CalendarRoutine(
        name: '물 마시기',
        startDate: DateTime.utc(2022, DateTime.july, 4),
        endDate: DateTime.utc(2022, DateTime.july, 8),
        duration: DateTime.utc(2022, DateTime.july, 4)
            .difference(DateTime.utc(2022, DateTime.july, 4))
            .inDays)
  ];

  int getRoutineCount() {
    return routines.length;
  }
}


// //An event already exists in the day
//                   if (controller
//                           .selectedEvents[controller.newEventTime.value] !=
//                       null) {
//                     print('existing event list');
//                     setState(
//                       () {
//                         iconCode = typeCode + colorCode + hardnessCode;
//                         controller
//                             .selectedEvents[controller.newEventTime.value]!
//                             .add(
//                           CalendarEvent(
//                               time: controller.newEventTime,
//                               color: markerColor,
//                               type: markerType,
//                               hardness: markerHardness,
//                               iconCode: iconCode,
//                               memo: eventTextController.text),
//                         );
//                       },
//                     );
//                     print(controller.selectedEvents[controller.selectedDay]
//                         .toString());
//                   }
//                   //No event exists in the day
//                   else {
//                     print('new event list');
//                     setState(() {
//                       iconCode = typeCode + colorCode + hardnessCode;
//                       controller.selectedEvents[controller.newEventTime.value] =
//                           [
//                         CalendarEvent(
//                             time: controller.newEventTime,
//                             color: markerColor,
//                             type: markerType,
//                             hardness: markerHardness,
//                             iconCode: iconCode,
//                             memo: eventTextController.text),
//                       ];
//                     });
//                     print(controller.selectedEvents[controller.selectedDay]
//                         .toString());
//                   }