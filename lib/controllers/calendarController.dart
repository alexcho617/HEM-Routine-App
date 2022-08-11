import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/models/calendarRoutine.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';
import 'loginService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    eventsLibrary = await fetchAllEvents();
    routineLibrary = await fetchAllRoutines();
    getCalendarLog();
    update();
  }

  LoginService loginService = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //initialize selected and focused Date
  //DateFormat('t').format(DateTime.now());
  var selectedDay = DateTime.now().obs;
  var focusedDate = DateTime.now().obs;
  DateTime newEventTime = DateTime.now();
  dynamic editIndex;
  //where events are stored, map of day to events
  RxMap eventsLibrary = {}.obs;

  //used in log
  List<CalendarEvent>? events = [];

  CalendarEvent? getLatestCalendarEvent() {
    CalendarEvent latest = CalendarEvent();
    Iterable keys = eventsLibrary.keys;
    List<dynamic> keyList = keys.toList();
    keyList.sort();
    List<CalendarEvent> latestDayEvents = eventsLibrary[keyList.last]; //events of the last day
    latest = latestDayEvents.first; //events are already stored in descending order
    return latest;
  }

  void getCalendarLog() {
    events = getEventsfromDay(parseDay(focusedDate.value));
    update();
  }

  //returns list of events from a given date
  List<CalendarEvent>? getEventsfromDay(DateTime? date) {
    return eventsLibrary[date];
  }

  String? getNumberOfEventsFromDay(DateTime date) {
    int? num = eventsLibrary[parseDay(date)]?.length;
    if (num != null && num > 1) {
      return '+${num - 1}';
    } else {
      return null;
    }
  }

  //where all routines are stored, listof calender routines
  List<CalendarRoutine> routineLibrary = [];

  int getRoutineCount() {
    return routineLibrary.length;
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

  void printAllRoutines() {
    print('---------PRINTING ALL ROUTINES----------');
    for (var routine in routineLibrary) {
      print(routine.toString());
    }
    print('---------END OF ALL ROUTINES----------');
  }
}
