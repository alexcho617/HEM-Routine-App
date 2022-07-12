import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        // child: Calendar(),
        // TextButton(onPressed: () => Get.toNamed('/login'), child: Text('login'))
      )),
      // body: SafeArea(child: TableRangeExample()),
    );
  }
}
