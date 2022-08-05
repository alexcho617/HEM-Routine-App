import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import 'package:hem_routine_app/models/routineItem.dart';

import '../widgets/widgets.dart';

class CustomRoutineItemController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<bool> isValid = [true, true].obs;
  Rx<bool> onSubmitted = false.obs;
  RxList<bool> activateButton = [false, false].obs;
  int categoryIndex = 0;
  List<String> categoryNames = [];

  List<TextEditingController> inputController =
      List<TextEditingController>.generate(
          2, (index) => TextEditingController());
  List<GlobalKey<FormState>> globalKeys =
      List<GlobalKey<FormState>>.generate(2, (index) => GlobalKey<FormState>());

  // List<Widget> categoryButtons = [];

  List<String> categories = [
    '수분 섭취',
    '운동/생활습관',
    '음식/식습관',
    '마이크로바이옴 관리',
    '멘탈 케어',
    '영양제/약',
    '기타'
  ];
  // RxList<bool> isSelected = List<bool>.generate(7, (index) {
  //   return index == 0 ? true : false;
  // }).obs;
  @override
  void onInit() {
    getRoutineItemNameList();
    super.onInit();
  }

  List<Widget> makeCategoryButtons() {
    List<Widget> categoryButtons = [];
    for (int i = 0; i < categories.length; i++) {
      // print(i);
      categoryButtons.add(routineCategoryButton(i, categories[i]));
    }
    return categoryButtons;
  }

  void updateCategoryIndex(int index) {
    // print('실행됨');
    categoryIndex = index;
    update();
  }

  void getRoutineItemNameList() async {
    //기존에 존재하던 items 받아오는 코드
    await firestore
        .collection('routineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        categoryNames.add(data['name']);
      });
    });

    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        categoryNames.add(data['name']);
      });
    });
  }

  Future<void> writeCustomRoutineItem() async {
    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .add({
      'name': inputController[0].text,
      'description': inputController[1].text,
      'category': categoryNames[categoryIndex],
    });
  }

  //이게 돌아왔을 때 routine Off가 꺼졌을 수도 있으니까. 이걸 잘 처리해야 해.
  Future<void> refreshRoutineItems() async {
    RoutineOffController routineOffController = Get.put(RoutineOffController());
    //only custom routine items list are updated.
    routineOffController.routineItems.add(RoutineItem(
      name: inputController[0].text,
      description: inputController[1].text,
      category: categoryNames[categoryIndex],
      isCustom: true,
    ));
    //이름에 따라 sorting
    routineOffController.routineItems
        .sort(((a, b) => a.name.compareTo(b.name)));
  }

  Widget routineCategoryButton(int index, String text) {
    return index == categoryIndex
        ? selectedRoutineButton(() {}, text)
        : unSelectedRoutineButton(() => updateCategoryIndex(index), text);
  }

  String? textValidator(String? value, int index) {
    if (index == 0) {
      if (!onSubmitted.value) {
        if (value == null || value.isEmpty) {
          isValid[index] = false;
          activateButton[index] = false;

          return '내용을 입력해주세요';
        } else if (value != null && value.length > 20 && index == 0) {
          isValid[index] = false;
          activateButton[index] = false;

          return '루틴 이름은 20자 이내로 입력해주세요.';
        }

        isValid[index] = true;
        activateButton[index] = true;

        return null;
      } else {
        // print('working');
        onSubmitted.value = false;
        if (categoryNames.contains(inputController[index].text)) {
          isValid[index] = false;
          activateButton[index] = false;
          inputController[index].clear();

          return '이미 사용하신 루틴 항목 이름이에요.';
        }
        //여기에 write하는 거.

      }
    } else if (index == 1) {
      if (value == null || value.isEmpty) {
        isValid[index] = false;
        activateButton[index] = false;

        return '내용을 입력해주세요';
      } else if (value != null && value.length > 30 && index == 0) {
        isValid[index] = false;
        activateButton[index] = false;

        return '루틴 설명 문구는 30자 이내로 입력해주세요.';
      }

      isValid[index] = true;
      activateButton[index] = true;

      return null;
    }
  }
}
