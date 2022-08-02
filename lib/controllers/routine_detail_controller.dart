import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';

import '../models/routine.dart';

class RoutineDetailController extends GetxController {
  RoutineDetailController({required this.uid});
  LoginService loginService = Get.find();

  dynamic uid;
  late DocumentSnapshot routineSnapshot;

  var name = "".obs;
  var days = 0.obs;
  var tryCount = 0.obs;
  var averageComplete = 0.obs;
  var averageRating = 0.obs;
  var routineItem = [].obs;
  var goals = [].obs;

  var isTapped = [];

  void tapState(bool value, int index) {
    routineItem[index].isTapped = value;
    update();
  }


  @override
  void onInit() async {
    super.onInit();
    routineSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('routine')
        .doc(uid)
        .get();

    await getData();
  }

  Future<void> getData() async {
    name.value = routineSnapshot.get('name');
    days.value = routineSnapshot.get('days');
    tryCount.value = routineSnapshot.get('tryCount');
    averageComplete.value = routineSnapshot.get('averageComplete');
    averageRating.value = routineSnapshot.get('averageRating');
    routineItem.value = routineSnapshot.get('routineItem');
    goals.value = routineSnapshot.get('goals');
    for (var i in routineItem) {
      isTapped.add(false);
    }
  }
}
