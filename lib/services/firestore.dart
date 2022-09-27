// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/controllers/report_controller.dart';
import 'package:hem_routine_app/models/calendar_event.dart';
import 'package:hem_routine_app/models/routine.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';

import '../controllers/login_service.dart';
import '../models/calendar_routine.dart';
import '../models/routine.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
LoginService loginService = Get.find();
CalendarController calendarController = Get.find();

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
  } on Exception catch (e) {
    Get.snackbar('에러', '배변 기록 추가 실패');
    print(e);
  }

  calendarController.eventsLibrary = await fetchAllEvents();
}

Future<void> editCalendarEvent(
    CalendarEvent newEvent, String uid, String docId) async {
  DocumentReference documentReference =
      _firestore.collection('user').doc(uid).collection('Events').doc(docId);

  try {
    await documentReference.update(({
      'memo': newEvent.memo,
      'time': newEvent.time,
      'color': newEvent.color,
      'type': newEvent.type,
      'hardness': newEvent.hardness,
      'iconCode': newEvent.iconCode
    }));
  } on Exception catch (e) {
    Get.snackbar('에러', '배변 기록 업데이트 실패');
    print(e);
  }

  calendarController.eventsLibrary = await fetchAllEvents();
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

  calendarController.eventsLibrary = await fetchAllEvents();
}

//최근 7일 데이터 불러오기
Future<RxMap> fetchPastSevenDaysEvent() async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');
  DateTime sevenDaysAgo = kLastDay.subtract(const Duration(days: 7));
  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  try {
    await eventCollectionReference
        .where("time", isGreaterThan: sevenDaysAgo)
        .orderBy("time", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        CalendarEvent event = CalendarEvent();
        event.eventId = doc.get("eventId");
        event.time = doc.get("time").toDate();
        event.type = doc.get("type");
        event.color = doc.get("color");
        event.hardness = doc.get("hardness");
        event.iconCode = doc.get("iconCode");
        event.memo = doc.get("memo");

        DateTime day = parseDay(event.time);
        if (eventMap[day] == null) {
          eventMap[day] = [event];
        } else {
          eventMap[day].add(event);
        }
      });
    });
  } on Exception catch (e) {
    // Get.snackbar('에러', '한 주간의 이벤트 데이터를 불러올 수 없습니다.');
    print(e);
  }
  return eventMap;
}

//이번 달 이벤트 불러오기
Future<RxMap> fetchThisMonthsEvent() async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');

  DateTime firstDayOfMonth = DateTime(kToday.year, kToday.month, 1);
  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  try {
    await eventCollectionReference
        .where("time", isGreaterThan: firstDayOfMonth)
        .orderBy("time", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        CalendarEvent event = CalendarEvent();
        event.eventId = doc.get("eventId");
        event.time = doc.get("time").toDate();
        event.type = doc.get("type");
        event.color = doc.get("color");
        event.hardness = doc.get("hardness");
        event.iconCode = doc.get("iconCode");
        event.memo = doc.get("memo");

        DateTime day = parseDay(event.time);
        if (eventMap[day] == null) {
          eventMap[day] = [event];
        } else {
          eventMap[day].add(event);
        }
      });
    });
  } on Exception catch (e) {
    // Get.snackbar('에러', '한 달간의 이벤트 데이터를 불러올 수 없습니다.');
    print(e);
  }
  return eventMap;
}

//사용 안 할 가능성 있음. fetchSixMonthSmooth 로 대체
//지난 달 이벤트 불러오기
Future<RxMap> fetchPreviousMonthsEvent(int monthsBefore) async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');
  //해당 달의 첫날 00시
  DateTime start = DateTime(kToday.year, kToday.month - monthsBefore, 1);
  //해당 달의 마지막날 자정 직전
  DateTime end =
      DateTime(kToday.year, kToday.month - monthsBefore, 31, 23, 59, 59);

  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  try {
    await eventCollectionReference
        .where("time", isGreaterThanOrEqualTo: start) //첫 날~마지막 날
        .where("time", isLessThanOrEqualTo: end)
        .orderBy("time", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        CalendarEvent event = CalendarEvent();
        event.eventId = doc.get("eventId");
        event.time = doc.get("time").toDate();
        event.type = doc.get("type");
        event.color = doc.get("color");
        event.hardness = doc.get("hardness");
        event.iconCode = doc.get("iconCode");
        event.memo = doc.get("memo");

        DateTime day = parseDay(event.time);
        if (eventMap[day] == null) {
          eventMap[day] = [event];
        } else {
          eventMap[day].add(event);
        }
      });
    });
  } on Exception catch (e) {
    // Get.snackbar('에러', '지난 $monthsBefore달 간의 이벤트 데이터를 불러올 수 없습니다.');
    print(e);
  }
  return eventMap;
}

Future<RxList> fetchPieChartData() async {
  final ReportController _reportController = Get.find();

  int count = 0;
  int water = 0;
  int smooth = 0;
  int hard = 0;
  RxList data = [].obs;

  var keyList = _reportController.monthEvents.keys.toList();
  //update
  for (var key in keyList) {
    List<CalendarEvent> events = _reportController.monthEvents[key];
    count += events.length;
    for (CalendarEvent event in events) {
      if (event.type == '0' || event.type == '1') {
        water += 1;
      } else if (event.type == '2' || event.type == '3' || event.type == '4') {
        smooth += 1;
      } else {
        hard += 1;
      }
    }
  }
  if (count != 0) {
    //asign
    data.add(((water / count) * 100).round() / 100);
    data.add(((smooth / count) * 100).round() / 100);
    data.add(((hard / count) * 100).round() / 100);
  }
  return data;
}

//리포트 페이지 6개월 라인 차트용
Future<RxList> fetchLineChartData(int monthsBefore) async {
  RxList data = [].obs;

  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');

  //옛날 데이터부터 지금까지.
  for (var offSet = monthsBefore; offSet >= 0; offSet--) {
    //해당 달의 첫날 00시
    DateTime start = DateTime(kToday.year, kToday.month - offSet, 1);
    //해당 달의 마지막날 자정 직전
    DateTime end = DateTime(
        kToday.year, kToday.month - offSet, 31, 23, 59, 59); //달의 31일 자정 직전
    // RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
    try {
      int bottom = 0;
      int top = 0;
      await eventCollectionReference
          .where("time", isGreaterThanOrEqualTo: start) //첫 날~마지막 날
          .where("time", isLessThanOrEqualTo: end)
          .orderBy("time", descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        bottom = querySnapshot.size;
      });

      if (bottom == 0) {
        data.add(0.0);
      } else {
        //event record exists
        await eventCollectionReference
            .where("time", isGreaterThanOrEqualTo: start) //첫 날~마지막 날
            .where("time", isLessThanOrEqualTo: end)
            .where("type", whereIn: ["2", "3", "4"])
            .orderBy("time", descending: true)
            .get()
            .then((QuerySnapshot querySnapshot) {
              top = querySnapshot.size;
            });

        data.add(((top / bottom) * 100).round() / 100);
      }
    } on Exception catch (e) {
      // Get.snackbar('에러', '$offSet달 전의 이벤트 데이터를 불러올 수 없습니다.');
      print(e);
    }
  }

  return data;
}

//리포트 페이지 컬러차트용
Future<RxList> fetchColorChartData(int days) async {
  RxList data = [].obs;
  RxMap colorMap = {
    "0": 0,
    "1": 0,
    "2": 0,
    "3": 0,
    "4": 0,
    "5": 0,
    "6": 0,
    "9": 0 // 9는 선택을 하지 않은것
  }.obs;
  DateTime daysAgo = DateTime.now().subtract(Duration(days: days));
  if (FirebaseAuth.instance.currentUser != null) {
    CollectionReference eventCollectionReference = _firestore
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('Events');

    try {
      int bottom = 0;
      // int top = 0;
      await eventCollectionReference
          .where("time", isGreaterThan: daysAgo)
          .orderBy("time", descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        bottom = querySnapshot.size;
        if (bottom != 0) {
          //do counting here
          // top = querySnapshot.size;
          querySnapshot.docs.forEach((doc) {
            String color = doc.get("color");

            colorMap[color] += 1;
          });
        } else {
          return "기록 없음";
        }

        var keyList = colorMap.keys.toList();
        for (var key in keyList) {
          if (key != "9") {
            data.add(((colorMap[key] / bottom) * 100).round() / 100);
          }
        }

        return data;
      });
    } on Exception catch (e) {
      // Get.snackbar('에러', '$daysAgo일 전의 색 데이터를 불러올 수 없습니다.');
      print(e);
    }
  }
  return data;
}

//모든 이벤트 들고오기 get all events and make it into map<DateTime, List<CalendarEvent>>
Future<RxMap> fetchAllEvents() async {
  CollectionReference eventCollectionReference = _firestore
      .collection('user')
      .doc(loginService.auth.value.currentUser!.uid)
      .collection('Events');

  RxMap eventMap = {}.obs; // Map<DateTime,List<CalendarEvent>>
  try {
    await eventCollectionReference
        .orderBy("time", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
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
    // Get.snackbar('에러', '캘린더 데이터를 불러올 수 없습니다.');
    print(e);
  }
  calendarController.getCalendarLog();

  return eventMap;
}

//fetch routine
Future<List<Routine>> fetchAllRoutines() async {
  List<Routine> routineList = [];
  try {
    if (loginService.auth.value.currentUser != null) {
      await _firestore
          .collection(
              'user/${loginService.auth.value.currentUser!.uid}/routine')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Routine currentRoutine = Routine();

          currentRoutine.averageComplete = doc["averageComplete"];
          currentRoutine.averageRating = doc["averageRating"];
          currentRoutine.days = doc["days"];
          currentRoutine.goals = doc["goals"];
          currentRoutine.id = doc.id;
          currentRoutine.name = doc["name"];
          currentRoutine.routineItem = doc["routineItem"];
          currentRoutine.tryCount = doc["tryCount"];

          routineList.add(currentRoutine);
        }
      });
    } else {
      print('firestore.dart_fetchAllRoutines():auth is null');
    }
  } on Exception catch (e) {
    print(e);
    // Get.snackbar('에러', '루틴 데이터를 불러올 수 없습니다.');
  }

  return routineList;
}

//this will fetch routine data from firestore
//fetch is not working corretl,y it is replacing all routines
Future<List<CalendarRoutine>> fetchAllCalendarRoutines() async {
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
    // Get.snackbar('에러', '루틴 데이터를 불러올 수 없습니다.');
  }

  return routineList;
}
