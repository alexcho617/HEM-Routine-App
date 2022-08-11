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

Future<void> addEventToCalendar(CalendarEvent newEvent, String uid) async {
  CollectionReference eventReference =
      _firestore.collection('user').doc(uid).collection('Events');

  //add document since doc id can be auto generated
  try {
    await eventReference
        .add(({
          'memo': newEvent.memo,
          'time': newEvent.time,
          'color': newEvent.color,
          'type': newEvent.type,
          'hardness': newEvent.hardness,
          'iconCode': newEvent.iconCode
        }))
        .then((DocumentReference docRef) =>
            docRef.update({'eventId': docRef.id}));
    // Get.snackbar('배변기록', '배변 기록이 추가되었습니다.', isDismissible: true);
  } on Exception catch (e) {
    Get.snackbar('에러', '배변 기록 추가 실패');
    print(e);
  }

  controller.eventsLibrary = await fetchAllEvents();
}

Future<void> editCalendarEvent(
    CalendarEvent newEvent, String uid, String docId) async {
  DocumentReference documentReference =
      _firestore.collection('user').doc(uid).collection('Events').doc(docId);

  //add document since doc id can be auto generated
  try {
    await documentReference.update(({
      'memo': newEvent.memo,
      'time': newEvent.time,
      'color': newEvent.color,
      'type': newEvent.type,
      'hardness': newEvent.hardness,
      'iconCode': newEvent.iconCode
    }));
    // Get.snackbar('배변기록', '배변 기록이 업데이트되었습니다.', isDismissible: true);
  } on Exception catch (e) {
    Get.snackbar('에러', '배변 기록 업데이트 실패');
    print(e);
  }

  controller.eventsLibrary = await fetchAllEvents();
}

Future<void> deleteCalendarEvent(String docId) async {
  DocumentReference documentReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events')
      .doc(docId);

  //add document since doc id can be auto generated
  try {
    await documentReference.delete();
    Get.snackbar('배변기록', '배변기록이 삭제되었습니다.', isDismissible: true);
  } on Exception catch (e) {
    Get.snackbar('에러', '배변 기록 삭제 실패');
    print(e);
  }

  controller.eventsLibrary = await fetchAllEvents();
}

//get all events and make it into map<DateTime, List<CalendarEvent>>
Future<RxMap> fetchAllEvents() async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');

  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  try {
    await eventCollectionReference.orderBy("time",descending: true).get().then((QuerySnapshot querySnapshot) {
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
        event.memo = doc.get("memo");

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
  } on Exception catch (e) {
    Get.snackbar('에러', '캘린더 데이터를 불러올 수 없습니다.');
    print(e);
  }
  controller.getCalendarLog();
  
  return eventMap;
}

//this will fetch routine data from firestore
//fetch is not working corretl,y it is replacing all routines
Future<List<CalendarRoutine>> fetchAllRoutines() async {
  List<CalendarRoutine> routineList = [];
  try {
    await _firestore
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        CalendarRoutine currentRoutine = CalendarRoutine();

        currentRoutine.startDate = parseDay(doc["startDate"].toDate());
        currentRoutine.endDate = parseDay(doc["endDate"].toDate());
        currentRoutine.duration = doc["duration"];
        currentRoutine.name = doc["name"];
        routineList.add(currentRoutine);
      }
    });
  } on Exception catch (e) {
    print(e);
    Get.snackbar('에러', '루틴 데이터를 불러올 수 없습니다.');
  }

  return routineList;
}
