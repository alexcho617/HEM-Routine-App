import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendar_event.dart';
import 'package:hem_routine_app/models/calendar_routine.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';
import 'login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    eventsLibrary = await fetchAllEvents();
    routineLibrary = await fetchAllCalendarRoutines();
    getCalendarLog();
    update();
  }

  void getAllData() async {
    eventsLibrary = await fetchAllEvents();
    routineLibrary = await fetchAllCalendarRoutines();
    getCalendarLog();
    update();
  }

  void clearAllData() {
    eventsLibrary.clear();
    routineLibrary.clear();
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
    if (keyList.isNotEmpty) {
      List<CalendarEvent> latestDayEvents = eventsLibrary[keyList.last];
      latest = latestDayEvents.first;
    }
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
}
