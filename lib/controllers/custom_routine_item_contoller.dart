// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/login_service.dart';
import 'package:hem_routine_app/controllers/routine_off_controller.dart';
import 'package:hem_routine_app/controllers/routine_item_setting_controller.dart';
import 'package:hem_routine_app/models/routine_item.dart';
import 'package:hem_routine_app/utils/constants.dart';

import '../widgets/widgets.dart';

class CustomRoutineItemController extends GetxController {
  CustomRoutineItemController({required this.args});
  ScreenArguments args;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<bool> isValid = [true, true].obs;
  Rx<bool> onSubmitted = false.obs;
  RxList<bool> activateButton = [false, false].obs;
  int categoryIndex = 0;
  //
  List<String> routineItemNames = [];

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
    if (args.crud == CRUD.update) {
      activateButton[0] = true;
      activateButton[1] = true;
    }
    updateInput();
    getRoutineItemNameList();
    super.onInit();
  }

  void updateInput() {
    if (args.crud == CRUD.update) {
      inputController[0].text = args.routineItem!.name;
      inputController[1].text = args.routineItem!.description;
      categoryIndex = categories
          .indexWhere((element) => element == args.routineItem!.category);
    }
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
        routineItemNames.add(data['name']);
      });
    });

    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        routineItemNames.add(data['name']);
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
      'category': categories[categoryIndex],
    });
  }

  Future<void> updateCustomRoutineItem(String docID) async {
    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .doc(docID)
        .set({
      'name': inputController[0].text,
      'description': inputController[1].text,
      'category': categories[categoryIndex],
    });
  }

  Future<void> deleteCustomRoutineItem() async {
    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .doc(args.routineItem!.docID)
        .delete();
    if (args.fromWhere == FromWhere.routineItemAdd) {
      //아 근데 그냥 가져오는데 리스트는 그대로 둬야 한다.
      await refreshRoutineItems();
    } else if (args.fromWhere == FromWhere.routineItemSetting) {
      Get.find<RotuineItemSettingController>().getCustomRoutineItemNameList();
    }
  }

  //이게 돌아왔을 때 routine Off가 꺼졌을 수도 있으니까. 이걸 잘 처리해야 해.
  Future<void> refreshRoutineItems() async {
    RoutineOffController routineOffController = Get.find();
    //only custom routine items list are updated.
    routineOffController.routineItems.add(RoutineItem(
      name: inputController[0].text,
      description: inputController[1].text,
      category: categories[categoryIndex],
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
        if (routineItemNames.contains(inputController[index].text)) {
          if (args.crud == CRUD.update &&
              args.routineItem!.name == inputController[index].text) {
            return null;
          } else {
            isValid[index] = false;
            activateButton[index] = false;
            inputController[index].clear();
          }

          return '이미 사용하신 루틴 항목 이름이에요.';
        }
        //여기에 write하는 거.

      }
    } else if (index == 1) {
      if (value == null || value.isEmpty) {
        isValid[index] = false;
        activateButton[index] = false;

        return '내용을 입력해주세요';
      } else if (value != null && value.length > 30 && index == 1) {
        isValid[index] = false;
        activateButton[index] = false;

        return '루틴 설명 문구는 30자 이내로 입력해주세요.';
      }

      isValid[index] = true;
      activateButton[index] = true;
    }
    return null;
  }

  void beforeBack() async {
    //이것만 달라지면 되는 것 같은데..?

    if (args.crud == CRUD.update) {
      await updateCustomRoutineItem(args.routineItem!.docID);
    } else if (args.crud == CRUD.create) {
      await writeCustomRoutineItem();
    } else if (args.crud == CRUD.delete) {}
    if (args.fromWhere == FromWhere.routineItemAdd) {
      //아 근데 그냥 가져오는데 리스트는 그대로 둬야 한다.
      await refreshRoutineItems();
    } else if (args.fromWhere == FromWhere.routineItemSetting) {
      Get.find<RotuineItemSettingController>().getCustomRoutineItemNameList();
    }
  }
}
