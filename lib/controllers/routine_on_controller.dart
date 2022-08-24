// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/controllers/login_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/routine_off_controller.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

class RoutineOnController extends GetxController {
  // // This code is for Testing
  // // Link to FireStore and get RoutineItems and eventCount
  // final countList = List<int>.generate(12, (index) => index * 5);
  // final routineItems = List<RoutineEntity>.generate(12, (int index) {
  //   return RoutineEntity(name: '루틴 항목 이름 $index', goalCount: (index + 1) * 7, index: index);
  // });
  RoutineOnController();
  LoginService loginService = Get.find();
  AppStateController appStateController = Get.find();
  late String uid;

  dynamic name = "".obs;
  dynamic goals = [].obs;
  RxList<dynamic> routineItems = [].obs;
  dynamic todayIndex = 0.obs;
  Rx<DateTime> today = DateTime.now().obs;
  Rx<DateTime> startday = DateTime.now().obs;
  dynamic days = 0.obs;
  dynamic selectedDayIndex = (-99).obs;
  dynamic isToday = true;
  dynamic isTodayFirstDay;

  dynamic selectedFilter = 0;
  dynamic selectedFilterString = "전체";

  dynamic currentCount = [].obs;

  dynamic dayCompletes = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0, //14
  ].obs;

  DocumentSnapshot? routineDocumentSnapshot;
  late DocumentSnapshot routineHistoryDocumentSnapshot;

  List<Event> events = [];

  DateTime selectedEventDateTime = DateTime.now();
  dynamic selectedEventIndex = -1;

  @override
  void onInit() async {
    uid = loginService.auth.value.currentUser!.uid;
    await getData();
    super.onInit();
  }

  Future<void> getAllData() async {
    uid = loginService.auth.value.currentUser!.uid;
    await getData();
  }

  void clearAllData() {
    name = "".obs;
    goals = [].obs;
    routineItems = [].obs;
    todayIndex = 0.obs;
    today = DateTime.now().obs;
    startday = DateTime.now().obs;
    days = 0.obs;
    selectedDayIndex = (-99).obs;
    isToday = true;

    selectedFilter = 0;
    selectedFilterString = "전체";

    currentCount = [].obs;

    dayCompletes = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0, //14
    ].obs;
  }

  Future<void> getData() async {
    routineDocumentSnapshot = await getRoutineData();
    if (routineDocumentSnapshot != null && routineDocumentSnapshot!.exists) {
      name.value = routineDocumentSnapshot!.get('name');
      days.value = routineDocumentSnapshot!.get('days');
      routineHistoryDocumentSnapshot = await getRoutineHistoryData();
      if (routineHistoryDocumentSnapshot.exists) {
        await getCurrday();
        selectedDayIndex.value = todayIndex.value;
        await getCurrCount();
        await getDayCompletes();
      }
    }
  }

  Future<DocumentSnapshot?> getRoutineData() async {
    // routineDocumentSnapshot null 일 경우 처리??
    DocumentSnapshot? documentSnapshot;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('routine')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // routineDocumentSnapshot = doc;
        documentSnapshot = doc;
      });
    });
    return documentSnapshot;
  }

  Future<DocumentSnapshot> getRoutineHistoryData() async {
    await routineDocumentSnapshot!.reference
        .collection('routineHistory')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        routineHistoryDocumentSnapshot = doc;
      });
    });

    return routineHistoryDocumentSnapshot;
  }

  Future<void> getCurrday() async {
    routineItems.value = routineHistoryDocumentSnapshot.get('routineItem');
    goals.value = routineHistoryDocumentSnapshot.get('goals');
    startday.value = routineHistoryDocumentSnapshot.get('startDate').toDate();
    todayIndex.value = today.value.difference(startday.value).inDays;
    if (today.value.difference(startday.value).inDays == 0) {
      isTodayFirstDay = true;
    } else {
      isTodayFirstDay = false;
    }
  }

  Future<void> getCurrCount() async {
    if (selectedDayIndex.value == todayIndex.value) {
      isToday = true;
    } else {
      isToday = false;
    }
    //initialize currentCount
    currentCount.value = [].obs;
    for (int i = 0; i < routineItems.value.length; i++) {
      currentCount.value.add(0);
    }
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc('${selectedDayIndex.value + 1}')
        .collection('routineItemHistory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //find index for routineItems by name and put currentCount value on it's index.
        // print(doc.get('name'));
        // print(currentCount);
        int ind = routineItems.value.indexOf(doc.get('name'));
        //print(doc.get('name') + " : " + ind.toString());
        currentCount.value[ind] = doc.get('currentCount');
        // print(currentCount.value);
      });
    });
  }

  itemReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final String itemToSwap1 = routineItems.value.removeAt(oldIndex);
    final int itemToSwap2 = goals.value.removeAt(oldIndex);
    final int itemToSwap3 = currentCount.value.removeAt(oldIndex);
    routineItems.value.insert(newIndex, itemToSwap1);
    goals.value.insert(newIndex, itemToSwap2);
    currentCount.value.insert(newIndex, itemToSwap3);

    await routineHistoryDocumentSnapshot.reference.update({
      'routineItem': routineItems.value,
      'goals': goals.value,
      // currentCount is referenced by doc id? dont have to change currentCount val here
    });
  }

  double getPercent(int eventCount, int goalCount) {
    double eCount = eventCount.toDouble();
    double gCount = goalCount.toDouble();

    double percent = eCount / gCount;
    if (percent > 1) percent = 1.0;
    return percent;
  }

  double getAvgPercentDay() {
    double avg = 0.0;
    if (goals.value.isEmpty || goals == null || goals.value == null) return avg;
    for (int i = 0; i < goals.value.length; i++) {
      avg += getPercent(currentCount.value[i], goals.value[i]);
    }
    avg /= goals.value.length;

    return avg;
  }

  Future<void> getDayCompletes() async {
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dayCompletes.value[int.parse(doc.id) - 1] = doc.get('dayComplete');
      });
    });
    update();
  }

  Rx<bool> isFinished = true.obs;
  Future<void> onPlusPressed(int index) async {
    isFinished.value = false;
    DateTime nowdt = DateTime.now();
    String nowst =
        DateFormat("HH").format(nowdt) + DateFormat("mm").format(nowdt);
    // print("nowst : $nowst");
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc('${selectedDayIndex.value + 1}')
        .collection('routineItemHistory')
        .where('name', isEqualTo: routineItems[index])
        .get()
        .then((QuerySnapshot querySnapshot) {
      currentCount.value[index]++;
      querySnapshot.docs.forEach((doc) async {
        List<dynamic> eventTime = [];
        eventTime = await doc.get('eventTime');
        if (isToday) {
          eventTime.add(nowst);
        } else {
          eventTime.add("NULL");
        }
        doc.reference.update({
          // 'currentCount': currentCount.value[index],
          'currentCount': FieldValue.increment(1),
          'eventTime': eventTime,
        });
      });
    });
    await getDayCompletes();
    await getAvgPercents();
    await dayComplete();

    update();

    isFinished.value = true;
  }

  Future<void> getAvgPercents() async {
    dayCompletes.value[selectedDayIndex.value] = getAvgPercentDay();
  }

  Future<void> dayComplete() async {
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .update({
      'dayComplete': dayCompletes.value[selectedDayIndex.value],
    });
  }

  String getSelectedDay() {
    final adnum = selectedDayIndex.value;
    final date = DateTime(startday.value.year, startday.value.month,
        (startday.value.day + adnum).toInt());
    final dateFormated = DateFormat('yyyy-MM-dd').format(date);
    return "($dateFormated)";
  }

  Future<void> fetchEvent() async {
    events = [];
    // Load all (event[] + name) in routineItemHistoy collection.
    // Put in List of Class
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .collection('routineItemHistory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        List<dynamic> eventTimes = [];
        eventTimes = doc.get('eventTime');
        for (var i in eventTimes) {
          Event event = Event();
          event.eventTime = i;
          event.name = doc.get('name');
          events.add(event);
        }
      });
    });
    sortByTime();
    // print(events);
    update();
  }

  void sortByTime() {
    events.sort(((a, b) => a.eventTime.compareTo(b.eventTime)));
  }

  String displayDate(String eventTime) {
    if (eventTime == "NULL") {
      return "-";
    } else {
      String meridiem = "오전 ";
      num hour = int.parse(eventTime[0] + eventTime[1]);
      if (hour > 12) {
        hour -= 12;
        meridiem = "오후 ";
      }
      return meridiem + hour.toString() + ":" + eventTime[2] + eventTime[3];
    }
  }

  String firebaseDate(DateTime eventTime) {
    return DateFormat('HH').format(eventTime) +
        DateFormat('mm').format(eventTime);
  }

  Future<void> deleteEvent(int index) async {
    // 해당 인덱스의 이름을 알아낸다. String eventName
    String eventName = events[index].name;
    //get index of eventName index
    num indexOfCount = routineItems.indexWhere((item) => item == eventName);
    currentCount[indexOfCount]--;

    // events 에서 해당 인덱스의 아이템을 삭제한다.
    events.removeAt(index);
    update();
    // eventName 이랑 동일한 이름을 가지는 instance들의 eventTime의 리스트를 새로 만든다. List<String> setEvents , 이때 리스트는 이미 삭제가 완료된 리스트이다.
    List<String> setEvents = [];
    for (var i in events) {
      if (i.name == eventName) {
        setEvents.add(i.eventTime);
      }
    }
    // print("setEvents : $setEvents");
    // setEvents를 eventName을 name으로 가지는 document에 eventItem으로 update한다.
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .collection('routineItemHistory')
        .where('name', isEqualTo: eventName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'eventTime': setEvents,
          'currentCount': currentCount.value[indexOfCount],
        });
      });
    });
    await getAvgPercents();
    await dayComplete();
    update();
  }

  Future<void> changeEvent(int index, String eventTime) async {
    // 해당 인덱스의 이름을 알아낸다. String eventName
    String eventName = events[index].name;
    //get index of eventName index
    // num indexOfCount = routineItems.indexWhere((item) => item == eventName);

    // events 에서 해당 인덱스의 아이템을 수정한다.
    events[selectedEventIndex].eventTime = eventTime;
    update();
    // eventName 이랑 동일한 이름을 가지는 instance들의 eventTime의 리스트를 새로 만든다. List<String> setEvents , 이때 리스트는 이미 수정이 완료된 리스트이다.
    List<String> setEvents = [];
    for (var i in events) {
      if (i.name == eventName) {
        setEvents.add(i.eventTime);
      }
    }
    // print("setEvents : $setEvents");
    // setEvents를 eventName을 name으로 가지는 document에 eventItem으로 update한다.
    await routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .collection('routineItemHistory')
        .where('name', isEqualTo: eventName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'eventTime': setEvents,
        });
      });
    });
    // await getAvgPercents();
    // await dayComplete();
    sortByTime();
    update();
  }

  Future<void> onDateTimeSave() async {
    routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .collection('routineItemHistory')
        .where('name', isEqualTo: events[selectedDayIndex].name)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          //update eventTime
        });
      });
    });
  }

  // late DocumentSnapshot activeRoutineSnapshot;
  // late DocumentSnapshot activeRoutineHistorySnapshot;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> offRoutineToday() async {
    // print("function: offRoutineToday called");
    routineDeactivate();
    routineHistoryDelete();
    routineOff();
  }

  Future<void> offRoutineNotToday() async {
    // print("function: offRoutineNotToday called");
    await appStateController.fetchRateRoutine();
    await setRoutineHistoryComplete();
    await setRoutineComplete();

    await routineDeactivate();
    await routineHistoryDeactivate();
    isRatedChecker();
    routineOff();
  }

  Future<double> setRoutineHistoryComplete() async {
    double completeTemp = getAvgPercentRoutineHistory();
    Get.find<AppStateController>().complete.value = completeTemp;
    await routineHistoryDocumentSnapshot.reference.update({
      'complete': completeTemp,
    });
    return completeTemp;
  }

  Future<double> setRoutineComplete() async {
    double avgComplete = 0.0;
    await routineDocumentSnapshot!.reference
        .collection('routineHistory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        avgComplete += doc.get('complete');
      });
      avgComplete /= querySnapshot.size;
    });
    await routineDocumentSnapshot!.reference
        .update({'averageComplete': avgComplete});
    return avgComplete;
  }

  Future<void> isRatedChecker() async {
    appStateController.isRated = false;
    appStateController.rateRoutineId = routineDocumentSnapshot!.id;
    appStateController.rateRoutineHistoryId = routineHistoryDocumentSnapshot.id;
    FirebaseFirestore.instance.collection('user').doc(uid).update({
      'isRated': false,
      'rateRoutineId': routineDocumentSnapshot!.id,
      'rateRoutineHistoryId': routineHistoryDocumentSnapshot.id,
    });
  }

  Future<void> getRoutineSnapshot() async {
    /// Get activeRoutineSnapshot at firestore
    await FirebaseFirestore.instance
        .collection('user/$uid/routine')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        // Get activeRoutineSnapshot
        // activeRoutineSnapshot = doc;
        routineDocumentSnapshot = doc;
      });
    });
  }

  Future<void> getActiveRoutineHistorySnapshot() async {
    /// Get activeRoutineHistorySnapshot at firestore
    assert(routineDocumentSnapshot!.exists);
    await FirebaseFirestore.instance
        .collection(
            'user/$uid/routine/${routineDocumentSnapshot!.id}/routineHistory')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot smallQuerySnapshot) {
      smallQuerySnapshot.docs.forEach((doc) async {
        // Get activeRoutineHistorySnapshot
        // activeRoutineHistorySnapshot = smallDoc;
        routineHistoryDocumentSnapshot = doc;
      });
    });
  }

  Future<void> routineDeactivate() async {
    /// Make Routine Document active to false
    assert(routineDocumentSnapshot!.exists);
    await FirebaseFirestore.instance
        .collection('user/$uid/routine')
        .doc(routineDocumentSnapshot!.id)
        .update({
      'isActive': false,
    });
  }

  Future<void> routineHistoryDelete() async {
    /// Delete Routine History at firestore. It should be executed when off routine && first day of Active Routine History
    assert(routineDocumentSnapshot!.exists);
    assert(routineHistoryDocumentSnapshot.exists);
    //routine 삭제
    await FirebaseFirestore.instance
        .collection(
            'user/$uid/routine/${routineDocumentSnapshot!.id}/routineHistory')
        .doc(routineHistoryDocumentSnapshot.id)
        .delete();
    //calendarRoutine 삭제
    await FirebaseFirestore.instance
        .collection('user/$uid/calendarRoutine')
        .doc(routineHistoryDocumentSnapshot.id)
        .delete();
  }

  Future<void> routineHistoryDeactivate() async {
    /// Make Routine History Document active to false. It should be executed at off routine, but NOT first day of Active Routine History
    assert(routineDocumentSnapshot!.exists);
    assert(routineHistoryDocumentSnapshot.exists);
    await FirebaseFirestore.instance
        .collection(
            'user/$uid/routine/${routineDocumentSnapshot!.id}/routineHistory')
        .doc(routineHistoryDocumentSnapshot.id)
        .update({
      'isActive': false,
    });
    await FirebaseFirestore.instance
        .collection('user/$uid/calendarRoutine')
        .doc(routineHistoryDocumentSnapshot.id)
        .update({
      'endDate': DateTime(today.value.year, today.value.month, today.value.day),
    });
  }

  void routineOff() {
    appStateController.status.value = false;
  }

  double getAvgPercentRoutineHistory() {
    double avg = 0.0;
    for (int i = 0; i < days.value; i++) {
      avg += dayCompletes[i];
    }
    avg /= days.value;
    return avg;
  }
}
