import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';

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
    // status.value = true;
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

  Future<void> offRoutine() async {
    //TODO: is active인 것을 찾아서 그것을 끄는게 필요
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .where('isActive', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        await firestore
            .collection(
                'user/${loginService.auth.value.currentUser!.uid}/routine')
            .doc(doc.id)
            .update({
          'isActive': false,
        });

        await firestore
            .collection(
                'user/${loginService.auth.value.currentUser!.uid}/routine/${doc.id}/routineHistory')
            .where('isActive', isEqualTo: true)
            .get()
            .then((QuerySnapshot smallQuerySnapshot) {
          smallQuerySnapshot.docs.forEach((smallDoc) async {
            await firestore
                .collection(
                    'user/${loginService.auth.value.currentUser!.uid}/routine/${doc.id}/routineHistory')
                .doc(smallDoc.id)
                .update({
              'isActive': false,
            });
          });
        });
      });
    });
    status.value = false;
  }
}
