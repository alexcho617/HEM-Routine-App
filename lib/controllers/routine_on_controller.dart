import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineOnController extends GetxController {
  // // This code is for Testing
  // // Link to FireStore and get RoutineItems and eventCount
  // final countList = List<int>.generate(12, (index) => index * 5);
  // final routineItems = List<RoutineEntity>.generate(12, (int index) {
  //   return RoutineEntity(name: '루틴 항목 이름 $index', goalCount: (index + 1) * 7, index: index);
  // });
  RoutineOnController();
  LoginService loginService = Get.find();

  dynamic name = "".obs;
  dynamic goals = [].obs;
  RxList<dynamic> routineItems = [].obs;
  dynamic todayIndex = 0.obs;
  Rx<DateTime> today = DateTime.now().obs;
  dynamic startday;
  dynamic days = 0.obs;
  dynamic selectedDayIndex = (-99).obs;
  dynamic isToday = true;

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

  dynamic routineDocumentSnapshot;
  late DocumentSnapshot routineHistoryDocumentSnapshot;
  // late DocumentSnapshot dayDocumentSnapshot;

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    routineDocumentSnapshot = await getRoutineData();
    if (routineDocumentSnapshot != null) {
      routineHistoryDocumentSnapshot = await getRoutineHistoryData();
      if (routineHistoryDocumentSnapshot != null) {
        await getCurrday();
        selectedDayIndex.value = todayIndex.value;
        await getCurrCount();
        await getDayCompletes();
      }
    }
  }

  Future<dynamic> getRoutineData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('routine')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        routineDocumentSnapshot = doc;
      });
    });

    if (routineDocumentSnapshot != null) {
      name.value = await routineDocumentSnapshot.get('name');
      days.value = await routineDocumentSnapshot.get('days');
    }

    return await routineDocumentSnapshot;
  }

  Future<DocumentSnapshot> getRoutineHistoryData() async {
    await routineDocumentSnapshot.reference
        .collection('routineHistory')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        routineHistoryDocumentSnapshot = doc;
      });
    });

    return routineHistoryDocumentSnapshot;
  }

  Future<void> getCurrday() async {
    routineItems.value = routineHistoryDocumentSnapshot.get('routineItem');
    goals.value = routineHistoryDocumentSnapshot.get('goals');
    startday = routineHistoryDocumentSnapshot.get('startDate').toDate();
    todayIndex.value = today.value.difference(startday).inDays;
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

  double getAvgPercent() {
    double avg = 0.0;
    if (goals.value.isEmpty || goals == null || goals.value == null) return avg;
    for (int i = 0; i < goals.value.length; i++) {
      avg += getPercent(currentCount.value[i], goals.value[i]);
    }
    avg /= goals.value.length;

    return avg;
  }

  Future<void> getDayCompletes() async {
    routineHistoryDocumentSnapshot.reference
        .collection('days')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dayCompletes.value[int.parse(doc.id) - 1] = doc.get('dayComplete');
      });
    });
  }

  void onPlusPressed(int index) {
    DateTime nowdt = DateTime.now();
    String nowst = nowdt.hour.toString() + nowdt.minute.toString();
    // print("nowst : $nowst");
    currentCount[index]++;
    routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc('${selectedDayIndex.value + 1}')
        .collection('routineItemHistory')
        .where('name', isEqualTo: routineItems[index])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dynamic eventTime = [];
        eventTime = doc.get('eventTime');
        if (isToday) {
          eventTime.add(nowst);
        } else {
          eventTime.add("NULL");
        }
        doc.reference.update({
          'currentCount': currentCount.value[index],
          'eventTime': eventTime,
        });
      });
    });

    dayCompletes.value[selectedDayIndex.value] = getAvgPercent();
    routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc("${selectedDayIndex.value + 1}")
        .update({
      'dayComplete': dayCompletes.value[selectedDayIndex.value],
    });
  }
}
