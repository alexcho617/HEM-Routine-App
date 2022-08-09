import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineEntityController.dart';
import 'package:hem_routine_app/models/routineEntity.dart';

import 'package:hem_routine_app/models/routineItem.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/routine/routineEntitySetting.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

//TODO: 아마 프로그램 흐름상 routine item읽어오는 건 다른 Controller로 구분해야 한다.
class RoutineOffController extends GetxController {
  LoginService loginService = Get.find();
  final inputController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  Rx<bool> onSubmitted = false.obs;
  Rx<bool> isValid = true.obs;
  Rx<bool> activateButton = false.obs;

  Rx<int> routinePeriodIndex = 1.obs;

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

  void initValues() {
    inputController.clear();
    isValid.value = true;
    activateButton.value = false;
  
    //화면을 나갈 때에 값들을 전부 초기화하기 위함
    
    for (int i = 0; i < routineItems.length; i++) {
      routineItems[i].isAdded = false;
      routineItems[i].isChecked = false;
    }
    update();
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
    //기존에 존재하던 items 받아오는 코드
    await firestore
        .collection('routineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        routineItems.add(RoutineItem(
          name: data['name'],
          category: data['category'],
          description: data['description'],
          docID: doc.id,
        ));
        if (categories.contains(data['category']) != true) {
          categories.add(data['category']);
        }
      });
    });

    await firestore
        .collection(
            'user/${loginService.auth.value.currentUser!.uid}/userRoutineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        routineItems.add(RoutineItem(
          name: data['name'],
          category: data['category'],
          description: data['description'],
          isCustom: true,
          docID: doc.id,
        ));
      });
    });

    //내가 직접 만든 항목도 카테코리 항목에 추가
    categories.add('직접 만든 항목');
    //이름에 따라 sorting
    routineItems.sort(((a, b) => a.name.compareTo(b.name)));

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
