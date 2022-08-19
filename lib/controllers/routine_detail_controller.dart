import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import 'package:hem_routine_app/controllers/routine_completed_controller.dart.dart';
import 'package:hem_routine_app/controllers/routine_on_controller.dart';

import '../services/firestore.dart';
import '../utils/calendarUtil.dart';

class RoutineDetailController extends GetxController {
  RoutineDetailController({required this.id});
  LoginService loginService = Get.find();
  RoutineCompletedController routineCompletedController =
      Get.put(RoutineCompletedController());
  DateTime now = DateTime.now();

  dynamic id;
  late DocumentSnapshot routineSnapshot;

  var name = "".obs;
  var days = 0.obs;
  var tryCount = 0.obs;
  var averageComplete = 0.0.obs;
  var averageRating = 0.0.obs;
  var routineItem = [].obs;
  var goals = [].obs;

  var isTapped = [];

  void tapState(bool value, int index) {
    routineItem[index].isTapped = value;
    update();
  }

  void deleteDoc() {
    routineCompletedController.routines
        .removeWhere((element) => element.id == routineSnapshot.id);
    routineSnapshot.reference.delete();
    routineCompletedController.update();
    Get.find<RoutineOffController>().getRoutineList();
  }

  @override
  void onInit() async {
    super.onInit();
    routineSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('routine')
        .doc(id)
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

  Future<void> addRoutineHistory() async {
    await FirebaseFirestore.instance
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .doc(id)
        .update({
      'tryCount': FieldValue.increment(1),
    });

    //DONE? : 수정하기
    DateTime later = now.add(Duration(days: days.value + 1));
    await FirebaseFirestore.instance
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/routine/$id/routineHistory')
        .add({
      'routineItem': routineItem,
      'goals': goals,
      'complete': 0.0,
      'duration': days.value,
      'startDate': DateTime(now.year, now.month, now.day),
      'endDate': DateTime(later.year, later.month, later.day),
      'isActive': true,
      'name': name.value,
      'rating': 0.0,
    }).then((DocumentReference routineHistoryDoc) async {
      for (int i = 1; i <= days.value; i++) {
        try {
          await FirebaseFirestore.instance
              .collection(
                  'user/${loginService.auth.value.currentUser!.uid}/routine/$id/routineHistory/${routineHistoryDoc.id}/days')
              .doc('$i')
              .set({
            'dayComplete': 0.0,
          });
        } on Exception catch (e) {
          print("line 94: " + e.toString());
        }

        for (int j = 0; j < routineItem.length; j++) {
          try {
            await FirebaseFirestore.instance
                .collection(
                    'user/${loginService.auth.value.currentUser!.uid}/routine/$id/routineHistory/${routineHistoryDoc.id}/days/$i/routineItemHistory')
                .add({
              'currentCount': 0,
              'goal': goals[j],
              'name': routineItem[j],
              'eventTime': []
            });
          } on Exception catch (e) {
            print("line 109: " + e.toString());
          }
        }
      }

      await routineSnapshot.reference.update({'isActive': true});
      Get.find<AppStateController>().status.value = true;
    });
  }

  Future<void> fetchData(BuildContext context) async {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    await addRoutineHistory();
    await addCalendarRoutine();
    await Get.find<RoutineOnController>().getData();

    Get.back();
  }

  Future<void> addCalendarRoutine() async{
    DateTime now = DateTime.now();
    DateTime later =
        now.add(Duration(days: days.value));
    //start alex calenderRoutine
      await FirebaseFirestore.instance //add calendar routine doc
          .collection(
              'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
          .doc(id)
          .set({
        'duration': days.value,
        'startDate': parseDay(now),
        'endDate': parseDay(later),
        'name': name.value,
      }).onError((error, _) =>
              print("Error adding document to calendarRoutine: $error"));

      //fetch routine collection and add to routineLibrary
      calendarController.routineLibrary = await fetchAllCalendarRoutines();
      calendarController.update();
      //end alex calenderRoutine

  }
}
