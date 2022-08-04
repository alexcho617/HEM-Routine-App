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
  dynamic name = "".obs;
  dynamic goals = [].obs;
  dynamic currentCount = [].obs;
  dynamic routineItems = [].obs;
  dynamic todayIndex = 0.obs;
  Rx<DateTime> today = DateTime.now().obs;
  dynamic startday;
  dynamic days = 0.obs;
  dynamic selectedDayIndex = 0.obs;
  LoginService loginService = Get.find();

  dynamic routineDocumentSnapshot;
  dynamic routineHistoryDocumentSnapshot;

  @override
  void onInit() async {
    super.onInit();

    await getData();
  }

  Future<void> getData() async {
    await getRoutineData();
    if (routineDocumentSnapshot != null) {
      getRoutineHistoryData();
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
      goals.value = routineDocumentSnapshot.get('goals');
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
    startday = routineHistoryDocumentSnapshot.get('startDate').toDate();
    todayIndex.value = today.value.difference(startday).inDays;
    selectedDayIndex = todayIndex;
  }

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineEntity itemToSwap = routineItems.value.removeAt(oldIndex);
    routineItems.value.insert(newIndex, itemToSwap);
    // print(routineItems);
  }

  double getPercent(int eventCount, int goalCount) {
    double eCount = eventCount.toDouble();
    double gCount = goalCount.toDouble();

    double percent = eCount / gCount;
    return percent;
  }

  void onPlusPressed() {
    // TODO : increse count in countList
    // TODO : calculate several completion
    // TODO : Firestore sync
  }
}
