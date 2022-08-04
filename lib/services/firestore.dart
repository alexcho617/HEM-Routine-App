import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';

import '../controllers/loginService.dart';
import '../models/calendarRoutine.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
LoginService loginService = Get.find();
CalendarController controller = Get.find();

//꼭 분 단위로 해야 할 까? 화장실을 분 단위로 가는 상황은 정상이 아닌데 시간 단위로 잘라도 괜찮지 않나?
Future<void> addEventToCalendar(CalendarEvent newEvent, String uid) async {
  CollectionReference eventReference =
      _firestore.collection('user').doc(uid).collection('Events');

  //add document since doc id can be auto generated
  await eventReference
      .add(({
        'memo': newEvent.memo,
        'time': newEvent.time,
        'color': newEvent.color,
        'type': newEvent.type,
        'hardness': newEvent.hardness,
        'iconCode': newEvent.iconCode
      }))
      .then(
          (DocumentReference docRef) => docRef.update({'eventId': docRef.id}));

  controller.eventsLibrary = await fetchAllEvents();
}

//get all events and make it into map<DateTime, List<CalendarEvent>>
// Future<Map<DateTime, List<CalendarEvent>>> fetchEvent(String uid) async {
Future<RxMap> fetchAllEvents() async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');

  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  await eventCollectionReference.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      // doc id event instance
      // check and put event instacne in Map<DateTime, List<event>>
      //read single doc
      CalendarEvent event = CalendarEvent();
      event.eventId = doc.get("eventId");
      event.time = doc.get("time").toDate();
      event.type = doc.get("type");
      event.color = doc.get("color");
      event.hardness = doc.get("hardness");
      event.iconCode = doc.get("iconCode");

      //check if its in map
      //not in the map then create a new list then add to map
      // DateTime day =
      //     DateTime(event.time.year, event.time.month, event.time.day);
      DateTime day = parseDay(event.time);
      if (eventMap[day] == null) {
        eventMap[day] = [event];
      } else {
        eventMap[day].add(event);
      }
    });
  });
  return eventMap;
}

//this will fetch routine data from firestore
Future<void> getAllCalendarRoutineData(
    List<CalendarRoutine> routineList) async {
  CalendarRoutine currentRoutine = CalendarRoutine();
  await _firestore
      .collection(
          'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      currentRoutine.startDate = doc["startDate"];
      currentRoutine.endDate = doc["endDate"];
      currentRoutine.duration = doc["duration"];
      currentRoutine.name = doc["name"];
      routineList.add(currentRoutine);
    }
  });
}
