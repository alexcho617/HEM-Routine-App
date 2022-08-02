// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/models/calendarRoutine.dart';
import 'loginService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarController extends GetxController {
  LoginService loginService = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //initialize selected and focused Date
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();
  var newEventTime = DateTime.now().obs;
  //where events are stored
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};

  //returns list of events from a given date
  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  int? getNumberOfEventsFromDay(DateTime? date) {
    int? num = selectedEvents[date]?.length;
    if (num != null && num > 1) {
      return num;
    } else {
      return null;
    }
  }

  //add a new event to selected events
  int addEvent(CalendarEvent event) {
    int flag = 0;
    //TODO mapping is not working properly. Its mapping to old event.
    //if event exists add to existing list
    if (selectedEvents[newEventTime.value] != null) {
      selectedEvents[newEventTime.value]!.add(event);
      flag = 1;
    }
    //else create new list
    else {
      List<CalendarEvent> eventList = [event];
      selectedEvents[newEventTime.value] = eventList;
      flag = 1;
    }
    if (flag == 1) {
      print(selectedEvents[newEventTime.value].toString());
      return 1;
    } else {
      return 0;
    }
  }

  //where routines are stored, not sure about the date time mapping.
  //List<CalendarRoutine> routines = [];
  List<CalendarRoutine> routines = [
    CalendarRoutine(
        name: '물 마시기',
        startDate: DateTime.utc(2022, DateTime.july, 4),
        endDate: DateTime.utc(2022, DateTime.july, 8),
        duration: DateTime.utc(2022, DateTime.july, 4)
            .difference(DateTime.utc(2022, DateTime.july, 4))
            .inDays)
  ];

  //this will fetch routine data from firestore
  Future<void> getAllCalendarRoutineData(
      List<CalendarRoutine> routineList) async {
    CalendarRoutine currentRoutine = CalendarRoutine();
    await firestore
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        currentRoutine.startDate = doc["startDate"];
        currentRoutine.endDate = doc["endDate"];
        currentRoutine.duration = doc["duration"];
        currentRoutine.name = doc["name"];
        routineList.add(currentRoutine);
      });
    });
  }

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