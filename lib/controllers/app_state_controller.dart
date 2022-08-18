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
    DateTime now = DateTime.now();
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
            Map<String, dynamic> data = smallDoc.data() as Map<String, dynamic>;
            //여기서 startDate를 읽어내서 오늘과 월, 일까지 같다면 삭제.
            if (data['startDate'] ==
                Timestamp.fromDate(DateTime(now.year, now.month, now.day))) {
              await firestore
                  .collection(
                      'user/${loginService.auth.value.currentUser!.uid}/routine/${doc.id}/routineHistory')
                  .doc(smallDoc.id)
                  .delete();
            } else {
              //그렇지 않으면 update
              await firestore
                  .collection(
                      'user/${loginService.auth.value.currentUser!.uid}/routine/${doc.id}/routineHistory')
                  .doc(smallDoc.id)
                  .update({
                'isActive': false,
              });
            }
          });
        });
      });
    });
    status.value = false;
  }
}
