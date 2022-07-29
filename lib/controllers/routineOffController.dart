import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineEntityController.dart';
import 'package:hem_routine_app/models/routineEtity.dart';

import 'package:hem_routine_app/models/routineItem.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/routine/routineEntrySetting.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
//TODO: 아마 프로그램 흐름상 routine item읽어오는 건 다른 Controller로 구분해야 한다.
class RoutineOffController extends GetxController {
  LoginService loginService = Get.find();
  final inputController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  Rx<bool> onSubmitted = false.obs;
  Rx<bool> isValid = true.obs;
  Rx<bool> activateButton = false.obs;

  Rx<int> routinePeriodIndex = 0.obs;
  DateTime now = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Widget> routinePeriod = [
    Text("1 일간"),
    Text("2 일간"),
    Text("3 일간"),
    Text("4 일간"),
    Text("5 일간"),
    Text("6 일간"),
    Text("7 일간"),
    Text("8 일간"),
    Text("9 일간"),
    Text("10 일간"),
    Text("11 일간"),
    Text("12 일간"),
    Text("13 일간"),
    Text("14 일간"),
  ];

  List<String> existingRoutineName = [];
  List<RoutineItem> routineItems = [];
  List<RoutineItem> addedRoutineItems = [];
  List<String> categories = ['전체'];
  List<Widget> categoryButtons = <Widget>[];
  int categoryIndex = 0;
  int selectedRoutineItemCount = 0;
  


  @override
  void onInit() {
    getRoutineList();
    getRoutineItemList();
    super.onInit();
  }

  void initRoutineItemsValue() {
    //TODO: 이전에 체크만 한 것들은 초기화시키되 내가 이미 추가한 것들은 체크된 상태로 두게끔
    for (int i = 0; i < routineItems.length; i++) {
      routineItems[i].isChecked = false;
      routineItems[i].isTapped = false;
    }

    categoryIndex = 0;
    selectedRoutineItemCount = 0;
    buildRoutineButtons();
    update();
  }

  void buildRoutineButtons() {
    categoryButtons.clear();
    for (int i = 0; i < categories.length; i++) {
      // print(i);
      if (i == 0) {
        categoryButtons.add(
          SizedBox(
            width: 21.w,
          ),
        );
      }
      categoryButtons.add(routineCategoryButton(i, categories[i]));
      if (i != categories.length - 1) {
        categoryButtons.add(
          SizedBox(
            width: 16.w,
          ),
        );
      } else {
        categoryButtons.add(
          SizedBox(
            width: 21.w,
          ),
        );
      }
    }
  }

  void getRoutineList() async {
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        existingRoutineName.add(data['name']);
      });
    });
  }

  void getRoutineItemList() async {
    await firestore
        .collection('routineItems')
        .orderBy("name", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        routineItems.add(RoutineItem(
          name: data['name'],
          category: data['category'],
          description: data['description'],
        ));
        if (categories.contains(data['category']) != true) {
          categories.add(data['category']);
        }
      });
    });
    // print(routineItems);
    buildRoutineButtons();
  }

  

  void checkState(bool value, int index) {
    routineItems[index].isChecked = value;
    update();
  }

  void tapState(bool value, int index) {
    routineItems[index].isTapped = value;
    update();
  }

  void updateCategoryIndex(int index) {
    // print('실행됨');
    categoryIndex = index;
    buildRoutineButtons();
    //index가 바뀌어도 어차피...routineList는 동일한 가봐.
    update();
  }

  void increaseSelectedRoutineCount() {
    selectedRoutineItemCount++;
    update();
  }

  void decreaseSelectedRoutineCount() {
    selectedRoutineItemCount--;
    update();
  }
  //TODO : calendarRoutine에도 생겨야 함.
  // void addRoutine() async {
  //   DateTime later = now.add(Duration(days: currentIndex.value + 1));
  //   await firestore
  //       .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
  //       .add({
  //     'averageComplete': 0,
  //     'averageRating': 0,
  //     'name': inputController.text
  //   }).then((DocumentReference routineDoc) async {
  //     // print(routineDoc.id);
  // //alex calenderRoutine
  //     await firestore
  //         .collection(
  //             'user/${loginService.auth.value.currentUser!.uid}/calendarRoutine')
  //         .doc(routineDoc.id)
  //         .set({
  //       'duration': currentIndex.value,
  //       'startDate': DateTime(now.year, now.month, now.day),
  //       'endDate': DateTime(later.year, later.month, later.day),
  //       'name': inputController.text,
  //     }).onError((error, _) =>
  //             print("Error adding document to calendarRoutine: $error"));

  //     await firestore
  //         .collection(
  //             'user/${loginService.auth.value.currentUser!.uid}/routine/${routineDoc.id}/routineHistory')
  //         .add({
  //       'complete': 0,
  //       'duration': currentIndex.value,
  //       'startDate': DateTime(now.year, now.month, now.day),
  //       'endDate': DateTime(later.year, later.month, later.day),
  //       'isActive': true,
  //       'name': inputController.text,
  //       'rating': 0,
  //     }).then((DocumentReference routineHistoryDoc) async {
  //       for (int i = 1; i <= currentIndex.value; i++) {
  //         await firestore
  //             .collection(
  //                 'user/${loginService.auth.value.currentUser!.uid}/routine/${routineDoc.id}/routineHistory/${routineHistoryDoc.id}/days')
  //             .doc('$i')
  //             .set({
  //           'dayComplete': 0,
  //         });
  //       }
  //     });
  //   });
  // }

  String? textValidator(String? value) {
    if (!onSubmitted.value) {
      if (value == null || value.isEmpty) {
        isValid.value = false;
        activateButton.value = false;

        return '내용을 입력해주세요';
      } else if (value != null && value.length > 20) {
        isValid.value = false;
        activateButton.value = false;

        return '20까지 입력 가능합니다.';
      }

      isValid.value = true;
      activateButton.value = true;

      return null;
    } else {
      onSubmitted.value = false;
      if (existingRoutineName.contains(inputController.text)) {
        isValid.value = false;
        activateButton.value = false;
        inputController.clear();

        return '이미 사용하신 루틴 이름이에요.';
      } else {
        // addRoutine();
      }
    }
  }
}
