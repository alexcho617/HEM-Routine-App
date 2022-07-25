// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';
// import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Calendar(),
        ),
        // TextButton(onPressed: () => Get.toNamed('/login'), child: Text('login'))
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_month_outlined),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.flag_outlined),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.analytics_outlined),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //     )
      //   ],
      // ),
      // body: SafeArea(child: TableRangeExample()),
    );
  }
}
