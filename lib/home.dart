import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/getxController/loginController.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loginController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          children: [
            if (controller.uid.value == '') Text('uid empty'),
            if (controller.uid.value != '') Text(controller.uid.value),
          ],
        ),
      ),
    );
  }
}
