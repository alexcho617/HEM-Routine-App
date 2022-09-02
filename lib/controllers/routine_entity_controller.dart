import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/controllers/login_service.dart';
import 'package:hem_routine_app/controllers/routine_off_controller.dart';
import 'package:hem_routine_app/controllers/routine_on_controller.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';
import '../models/routine_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineEntityController extends GetxController {
  List<RoutineEntity> routineEntities = [];
  int addedRoutineItemCount = 0;
  LoginService loginService = Get.find();
  RoutineOffController controller = Get.find();
  CalendarController calendarController = Get.find();

  List<TextEditingController> inputControllers = <TextEditingController>[];
  DateTime now = DateTime.now();
  String routineId = '';
  String routineHistoryId = '';

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

  Future<bool> addRoutine() async {
    
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
      'todaysRecord': false,
      'days': controller.routinePeriodIndex.value,
      'averageComplete': 0.0,
      'averageRating': 0.0,
      'name': controller.inputController.text,
      'routineItem': routineItems,
      'goals': routineGoalCount,
      'tryCount': 1,
    }).then((DocumentReference routineDoc) async {
      routineId = routineDoc.id;
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
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .doc(routineId)
        .update({'isActive': true});
    await controller.firestore
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/routine/$routineId/routineHistory')
        .add({
      'routineItem': routineItems,
      'complete': 0,
      'duration': controller.routinePeriodIndex.value,
      'startDate': DateTime(now.year, now.month, now.day),
      'endDate': DateTime(later.year, later.month, later.day),
      'isActive': true,
      'name': controller.inputController.text,
      'rating': 0,
      'goals': routineGoalCount,
      'isCompleted' : [false,false,false,false,false,false,false,false,false,false,false,false,false,false],
    }).then((DocumentReference routineHistoryDoc) async {
      routineHistoryId = routineHistoryDoc.id;
      //start alex calenderRoutine
      await controller.firestore //add calendar routine doc
          .collection(
              'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
          .doc(routineHistoryDoc.id)
          .set({
        'duration': controller.routinePeriodIndex.value,
        'startDate': parseDay(now),
        'endDate': parseDay(later),
        'name': controller.inputController.text,
      }).onError((error, _) {
        if (kDebugMode) {
          print("Error adding document to calendarRoutine: $error");
        }
      });

      //fetch routine collection and add to routineLibrary
      calendarController.routineLibrary = await fetchAllCalendarRoutines();
      calendarController.update();
      //end alex calenderRoutine

      //며칠 만큼 반복할 것인가
      //이게 지금 1인가봐
      for (int i = 1; i <= controller.routinePeriodIndex.value; i++) {
        await controller.firestore
            .collection(
                'user/${loginService.auth.value.currentUser!.uid}/routine/$routineId/routineHistory/${routineHistoryDoc.id}/days')
            .doc('$i')
            .set({
          'dayComplete': 0.0,
        });
        //이것도 1인듯
        for (int j = 0; j < routineItems.length; j++) {
          await controller.firestore
              .collection(
                  'user/${loginService.auth.value.currentUser!.uid}/routine/$routineId/routineHistory/${routineHistoryDoc.id}/days/$i/routineItemHistory')
              .add({
            'currentCount': 0,
            'goal': routineGoalCount[j],
            'name': routineItems[j],
            'eventTime': []
          });
        }
      }
      await controller.firestore
          .collection('user')
          .doc(loginService.auth.value.currentUser!.uid)
          .update({
            'rateRoutineId' : routineId,
            'rateRoutineHistoryId' : routineHistoryId,
          });
    });

    Get.find<RoutineOnController>().getData();
    Get.find<RoutineOffController>().getRoutineList();

    await Get.find<AppStateController>().isUserHaveRated(loginService.auth.value.currentUser!.uid);
    await Get.find<AppStateController>().fetchRateRoutine();
    // await Get.find<AppStateController>().setIsRatedTrue();
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

  bool validateGoalCount() {
    bool result = true;
    for (int i = 0; i < routineEntities.length; i++) {
      if (inputControllers[i].text.isEmpty ||
          int.parse(inputControllers[i].text) > 20 || int.parse(inputControllers[i].text) <= 0) {
        inputControllers[i].clear();
        result = false;
      }
    }
    return result;
  }
}
