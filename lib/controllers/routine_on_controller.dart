import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/models/routineEntity.dart';
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
  dynamic routineItems = [].obs;
  dynamic todayIndex = 0.obs;
  Rx<DateTime> today = DateTime.now().obs;
  dynamic startday;
  dynamic days = 0.obs;
  dynamic selectedDayIndex = 0.obs;

  dynamic currentCount = [].obs;

  dynamic routineDocumentSnapshot;
  late DocumentSnapshot routineHistoryDocumentSnapshot;

  @override
  void onInit() async {
    super.onInit();
    await getData();
    selectedDayIndex.value = todayIndex.value;
  }

  Future<void> getData() async {
    await getRoutineData();
    if (routineDocumentSnapshot != null) {
      await getRoutineHistoryData();
      if (routineHistoryDocumentSnapshot != null) {
        await getCurrCount();
      }
    }
  }

  Future<void> getRoutineData() async {
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
      name.value = routineDocumentSnapshot.get('name');
      days.value = routineDocumentSnapshot.get('days');
    }
  }

  Future<void> getRoutineHistoryData() async {
    await routineDocumentSnapshot.reference
        .collection('routineHistory')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        routineHistoryDocumentSnapshot = doc;
      });
    });
    await getCurrday();
  }

  Future<void> getCurrday() async {
    routineItems.value = routineHistoryDocumentSnapshot.get('routineItem');
    goals.value = routineHistoryDocumentSnapshot.get('goals');
    startday = routineHistoryDocumentSnapshot.get('startDate').toDate();
    todayIndex.value = today.value.difference(startday).inDays;
  }

  Future<void> getCurrCount() async {
    for (int i = 0; i < routineItems.value.length; i++) {
      currentCount.value.add(0);
    }
    routineHistoryDocumentSnapshot.reference
        .collection('days')
        .doc('${selectedDayIndex.value + 1}')
        .collection('routineItemHistory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //find index for routineItems by name and put currentCount value on it's index.
        print(doc.get('name'));
        print(currentCount);
      });
    });
  }

  itemReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    //TODO : sawp currval
    final String itemToSwap1 = routineItems.value.removeAt(oldIndex);
    final int itemToSwap2 = goals.value.removeAt(oldIndex);
    routineItems.value.insert(newIndex, itemToSwap1);
    goals.value.insert(newIndex, itemToSwap2);

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

  void onPlusPressed() {
    // TODO : increse count in countList
    // TODO : calculate several completion
    // TODO : Firestore sync

    // TO DEL: FOR TEST
    print('plus button pressed');
  }
}
