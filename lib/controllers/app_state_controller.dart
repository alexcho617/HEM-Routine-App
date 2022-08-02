import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';

class AppStateController extends GetxController {
  Rx<bool> status = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginService loginService = Get.find();
  @override
  void onInit() {
    isRoutineActive();
    super.onInit();
  }

  void isRoutineActive() async {
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .where("isActive", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        print('Routine is active');
        status.value = true;
      });
    });
  }
}
