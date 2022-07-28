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

  //where events are stored
  Map<DateTime, List<CalendarEvent>> selectedEvents = {};

  //returns list of events from a given date
  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }

  //add a new event to selected events
  void addEvent(DateTime date, CalendarEvent event) {
    //if event exists add to existing list
    if (selectedEvents[date] != null) {
      selectedEvents[date]!.add(event);
    }
    //else create new list
    else {
      List<CalendarEvent> eventList = [event];
      selectedEvents[date] = eventList;
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
