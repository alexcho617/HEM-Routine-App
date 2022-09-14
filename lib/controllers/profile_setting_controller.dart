import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/login_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileSettingController extends GetxController {
  LoginService loginService = Get.find();
  final nameController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  bool isMale = true;
  bool enableBtn = false;

  @override
  void onInit() async {
    await getProfileProperty();
    super.onInit();
  }

  Future<void> getProfileProperty() async {
    bool _b = await loginService.getProfile();
    if (_b) {
      selectedDateTime = await loginService.getBirthDay();
      if (loginService.gender == 'Female') {
        isMale = false;
      } else {
        isMale = true;
      }
      nameController.text = loginService.name.value;
    }
  }
}
