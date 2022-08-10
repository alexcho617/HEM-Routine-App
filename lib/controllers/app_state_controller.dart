import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import '../controllers/loginService.dart';
import '../controllers/calendarController.dart';
import '../models/calendarEvent.dart';


class AppStateController extends GetxController {
  Rx<bool> status = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginService loginService = Get.find();

  CalendarController calendarController = Get.find();

  //TODO : 가장 최신 이벤트
  String getLatestCalendarMessage() {
    CalendarEvent? latestEvent = calendarController.getLatestCalendarEvent();
    if (latestEvent != null) {
      return parseCalendarMessage(latestEvent);
    } else {
      return '배변 기록을 추가하세요.';
    }
  }


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
