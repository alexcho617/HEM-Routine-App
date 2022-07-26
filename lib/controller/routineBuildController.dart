import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controller/loginService.dart';

class RoutineBuildController extends GetxController {
  LoginService loginService = Get.find();
  final inputController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  Rx<bool> onSubmitted = false.obs;
  Rx<bool> isValid = true.obs;
  Rx<bool> activateButton = false.obs;
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
    Text("15 일간")
  ];

  List<String> routineName = [];
  @override
  void onInit() {
    getRoutineList();
    super.onInit();
  }

  void getRoutineList() async {
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        routineName.add(data['name']);
      });
    });
    // print(routineName);
  }

  void addRoutine() async {
    // await firestore
    //     .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
    //     .where("name", isEqualTo: inputController.text)
    //     .get()
    //     .then((QuerySnapshot querySnapshot) async {
    //   if (querySnapshot.size == 0) {
    await firestore
        .collection('user/${loginService.auth.value.currentUser!.uid}/routine')
        .add({
      'averageComplete': 0,
      'averageRating': 0,
      'name': inputController.text
    }).then((DocumentReference documentReference) {
      print(documentReference.id);
    });
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
      if (routineName.contains(inputController.text)) {
        isValid.value = false;
        activateButton.value = false;
        inputController.clear();
        
        return '이미 사용하신 루틴 이름이에요.';
      } else {
        addRoutine();
      }
    }
  }
}