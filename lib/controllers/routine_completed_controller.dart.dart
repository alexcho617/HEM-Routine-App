import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/models/routine.dart';

class RoutineCompletedController extends GetxController {
  LoginService loginService = Get.find();
  late QuerySnapshot routineCompleted;
  RxList routines = [].obs;
  var sorting = "이름 순".obs;

  @override
  void onInit() async {
    super.onInit();
    routineCompleted = await FirebaseFirestore.instance
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('routine')
        .get();

    await getData();
    print("OnInit Called!");
  }

  Future<void> getData() async {
    for (var doc in routineCompleted.docs) {
      Routine routine = Routine();
      routine.averageComplete = doc.get("averageComplete");
      routine.averageRating = doc.get("averageRating").toDouble();
      routine.name = doc.get("name");
      routine.routineItem = doc.get("routineItem");
      routine.days = doc.get("days");
      routine.goals = doc.get("goals");
      routine.isActive = doc.get("isActive");
      routine.tryCount = doc.get("tryCount");
      routine.id = doc.id;

      routines.add(routine);
    }
    sortByName();
  }

  void sortByName() {
    routines.sort(((a, b) => a.name.compareTo(b.name)));
  }

  void sortByRank() {
    routines.sort(((b, a) => a.averageRating.compareTo(b.averageRating)));
  }

  void sortByCompleted() {
    routines.sort(((b, a) => a.averageComplete.compareTo(b.averageComplete)));
  }

  void sortByTry() {
    routines.sort(((b, a) => a.tryCount.compareTo(b.tryCount)));
  }
}
