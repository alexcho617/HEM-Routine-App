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
  late dynamic goals = [].obs;
  late dynamic currentCount = [].obs;
  late dynamic routineItems = [].obs;
  late 
  LoginService loginService = Get.find();

  late DocumentSnapshot routineDocumentSnapshot;
  late DocumentSnapshot routineHistoryDocumentSnapshot;

  @override
  void onInit() async {
    super.onInit();
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

    await routineDocumentSnapshot.reference
        .collection('routineHistory')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        routineHistoryDocumentSnapshot = doc;
      });
    });

    routineItems = routineHistoryDocumentSnapshot.get('routineItem');
    goals = routineDocumentSnapshot.get('goals');

    // await getData();
  }

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineEntity itemToSwap = routineItems.removeAt(oldIndex);
    routineItems.insert(newIndex, itemToSwap);
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
