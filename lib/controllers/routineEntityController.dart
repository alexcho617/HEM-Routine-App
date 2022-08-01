//TODO: routineOffController의 항목이 추가되는 대로 반영하기 또 순서도 마찬가지.
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import '../models/routineEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineEntityController extends GetxController {
  List<RoutineEntity> routineEntities = [];
  int addedRoutineItemCount = 0;
  LoginService loginService = Get.find();
  RoutineOffController controller = Get.find();
  List<TextEditingController> inputControllers = <TextEditingController>[];
  DateTime now = DateTime.now();

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
  void addRoutine() async {
    DateTime later =
        now.add(Duration(days: controller.routinePeriodIndex.value + 1));
    List<String> routineItems = [];
    List<int> routineGoalCount = [];
    for (int i = 0; i < routineEntities.length; i++) {
      routineItems.add(routineEntities[i].name);
      routineGoalCount.add(int.parse(inputControllers[i].text));
    }
    await controller.firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .add({
      'averageComplete': 0,
      'averageRating': 0,
      'name': controller.inputController.text,
      'routineItem': routineItems,
      'goals': routineGoalCount
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

      await controller.firestore
          .collection(
              'user/${loginService.auth.value.currentUser!.uid}/routine/${routineDoc.id}/routineHistory')
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
        // print('Executed??');
        for (int i = 1; i <= controller.routinePeriodIndex.value; i++) {
          // print('Executed!');
          await controller.firestore
              .collection(
                  'user/${loginService.auth.value.currentUser!.uid}/routine/${routineDoc.id}/routineHistory/${routineHistoryDoc.id}/days')
              .doc('$i')
              .set({
            'dayComplete': 0,
          });

          for (int j = 0; j < routineItems.length; j++) {
            await controller.firestore
                .collection(
                    'user/${loginService.auth.value.currentUser!.uid}/routine/${routineDoc.id}/routineHistory/${routineHistoryDoc.id}/days/$i/routineItemHistory')
                .add({
              'currentCount': 0,
              'goal': routineGoalCount[j],
              'name': routineItems[j],
              'eventTime': []
            });
          }
        }
      });
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
    addedRoutineItemCount--;
    update();
  }

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineEntity itemToSwap = routineEntities.removeAt(oldIndex);
    routineEntities.insert(newIndex, itemToSwap);
    //여기서 바로 write를 해야 한다.
  }
}
