import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';

class AppStateController extends GetxController {
  Rx<bool> status = false.obs;
  Rx<String> name = "".obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginService loginService = Get.find();
  @override
  void onInit() {
    isRoutineActive();
    super.onInit();
  }

  void isRoutineActive() async {
    // status.value = true;
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .where("isActive", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        name.value = document.get('name');
        print('Routine is active');
        status.value = true;
      });
    });
  }
}
