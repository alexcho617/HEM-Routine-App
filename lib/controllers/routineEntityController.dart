import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import '../models/routineEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_state_controller.dart';

class RoutineEntityController extends GetxController {
  List<RoutineEntity> routineEntities = [];
  int addedRoutineItemCount = 0;
  LoginService loginService = Get.find();
  RoutineOffController controller = Get.find();
  List<TextEditingController> inputControllers = <TextEditingController>[];
  DateTime now = DateTime.now();
  String uid = '';

  

  void buildRoutineEntities() {
    RoutineOffController controller = Get.find();
    for (int i = 0; i < controller.routineItems.length; i++) {
      if (controller.routineItems[i].isChecked == true &&
          controller.routineItems[i].isAdded == false) {
        controller.routineItems[i].isAdded = true;
        //index는 reorderable의 구동방식을 이해하고 해야겠다.
        routineEntities.add(RoutineEntity(
            name: controller.routineItems[i].name,
            index: addedRoutineItemCount++));
        inputControllers.add(TextEditingController());
      }
    }
    update();
  }

//TODO : calendarRoutine에도 생겨야 함.
  Future<bool> addRoutine() async {
    print(loginService.auth.value.currentUser!.uid);
    DateTime later =
        now.add(Duration(days: controller.routinePeriodIndex.value));
    List<String> routineItems = [];
    List<int> routineGoalCount = [];
    for (int i = 0; i < routineEntities.length; i++) {
      routineItems.add(routineEntities[i].name);
      routineGoalCount.add(int.parse(inputControllers[i].text));
    }
    await controller.firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .add({
      'isActive': false,
      'days': controller.routinePeriodIndex.value,
      'averageComplete': 0,
      'averageRating': 0.0,
      'name': controller.inputController.text,
      'routineItem': routineItems,
      'goals': routineGoalCount,
      'tryCount': 1,
    }).then((DocumentReference routineDoc) async {
      // print(routineDoc.id);
      //alex calenderRoutine
      await controller.firestore
          .collection(
              'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
          .doc(routineDoc.id)
          .set({
        'duration': controller.routinePeriodIndex.value,
        'startDate': DateTime(now.year, now.month, now.day),
        'endDate': DateTime(later.year, later.month, later.day),
        'name': controller.inputController.text,
      }).onError((error, _) =>
              print("Error adding document to calendarRoutine: $error"));
      uid = routineDoc.id;
    });
    return false;
  }

  Future<void> startRoutine() async {
    DateTime now = DateTime.now();
    DateTime later =
        now.add(Duration(days: controller.routinePeriodIndex.value));
    List<String> routineItems = [];
    List<int> routineGoalCount = [];
    for (int i = 0; i < routineEntities.length; i++) {
      routineItems.add(routineEntities[i].name);
      routineGoalCount.add(int.parse(inputControllers[i].text));
    }

    await controller.firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine').
        doc(uid).update({
          'isActive': true
        });
    await controller.firestore
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/routine/$uid/routineHistory')
        .add({
      'routineItem': routineItems,
      'complete': 0,
      'duration': controller.routinePeriodIndex.value,
      'startDate': DateTime(now.year, now.month, now.day),
      'endDate': DateTime(later.year, later.month, later.day),
      'isActive': true,
      'name': controller.inputController.text,
      'rating': 0,
    }).then((DocumentReference routineHistoryDoc) async {
      //며칠 만큼 반복할 것인가
      for (int i = 1; i <= controller.routinePeriodIndex.value; i++) {
        // print('Executed!');
        await controller.firestore
            .collection(
                'user/${loginService.auth.value.currentUser!.uid}/routine/$uid/routineHistory/${routineHistoryDoc.id}/days')
            .doc('$i')
            .set({
          'dayComplete': 0,
        });

        for (int j = 0; j < routineItems.length; j++) {
          await controller.firestore
              .collection(
                  'user/${loginService.auth.value.currentUser!.uid}/routine/$uid/routineHistory/${routineHistoryDoc.id}/days/$i/routineItemHistory')
              .add({
            'currentCount': 0,
            'goal': routineGoalCount[j],
            'name': routineItems[j],
            'eventTime': []
          });
          return true;
        }
      }
    });
  }

  void deleteRoutineEntities(int index) {
    RoutineOffController controller = Get.find();

    for (int i = 0; i < controller.routineItems.length; i++) {
      if (controller.routineItems[i] == routineEntities[index].name) {
        controller.routineItems[i].isAdded = false;
      }
    }
    routineEntities.removeAt(index);
    inputControllers.removeAt(index);
    addedRoutineItemCount--;
    update();
  }

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineEntity itemToSwap = routineEntities.removeAt(oldIndex);
    routineEntities.insert(newIndex, itemToSwap);

    final TextEditingController controllerToSwap =
        inputControllers.removeAt(oldIndex);
    inputControllers.insert(newIndex, controllerToSwap);
    //여기서 바로 write를 해야 한다.
  }
}
