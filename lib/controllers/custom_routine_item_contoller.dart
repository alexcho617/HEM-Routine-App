import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/widgets.dart';

class CustomRoutineItemController extends GetxController {
  Rx<bool> isValid = false.obs;
  TextEditingController inputController = TextEditingController();
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
  int categoryIndex = 0;
  RxBool activateButton = false.obs;


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


  Widget routineCategoryButton(int index, String text) {
    return index == categoryIndex
        ? selectedRoutineButton(() {}, text)
        : unSelectedRoutineButton(
            () => updateCategoryIndex(index), text);
  }
}
