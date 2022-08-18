import 'package:flutter/material.dart';
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
  DateTime now = DateTime.now();
  late String uid;

  String getLatestCalendarMessage() {
    CalendarEvent? latestEvent =
        Get.find<CalendarController>().getLatestCalendarEvent();
    if (latestEvent != null) {
      return Get.find<RoutineOffController>().parseRoutineMessage(latestEvent);
    } else {
      return '배변 기록을 추가하세요.';
    }
  }

  @override
  void onInit() async {
    uid = loginService.auth.value.currentUser!.uid;
    if (loginService.auth.value.currentUser != null) {
      await isRoutineActive();
      await isUserHaveRated();
    }
    super.onInit();
  }

  Future<void> isRoutineActive() async {
    // status.value = true;
    await firestore
        .collection('user/$uid/routine')
        .where("isActive", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        status.value = true;
      });
    });
    print('Routine is active');
  }

  Future<void> isUserHaveRated() async {
    await firestore
        .collection('user')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      //check isRated
      loginService.isRated = documentSnapshot.get('isRated');
    });
  }

  Future<void> offRoutine() async {
    // await firestore
    //     .collection('user/$uid/routine')
    //     .where('isActive', isEqualTo: true)
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) async {
    //     // Get activeRoutineSnapshot
    //     activeRoutineSnapshot = doc;
    //     await routinDeactivate();
    //     await firestore
    //         .collection('user/$uid/routine/${doc.id}/routineHistory')
    //         .where('isActive', isEqualTo: true)
    //         .get()
    //         .then((QuerySnapshot smallQuerySnapshot) {
    //       smallQuerySnapshot.docs.forEach((smallDoc) async {
    //         // Get activeRoutineHistorySnapshot
    //         activeRoutineHistorySnapshot = smallDoc;
    //         Map<String, dynamic> data = smallDoc.data() as Map<String, dynamic>;
    //         //여기서 startDate를 읽어내서 오늘과 월, 일까지 같다면 삭제.
    //         if (data['startDate'] ==
    //             Timestamp.fromDate(DateTime(now.year, now.month, now.day))) {
    //           routineHistoryDelete();
    //         } else {
    //           routineHistoryDeactivate();
    //         }
    //       });
    //     });
    //   });
    // });
    status.value = false;
  }
}
