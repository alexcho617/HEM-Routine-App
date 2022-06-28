import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hem_routine_app/utils/constants.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  var widgetOptions = <Widget>[
    Text(
      'Index 0: 캘린더',
      style: kBottomNavigationOptionStyle,
    ),
    Text(
      'Index 1: 루틴 도전',
      style: kBottomNavigationOptionStyle,
    ),
    Text(
      'Index 2: 리포트',
      style: kBottomNavigationOptionStyle,
    ),
    Text(
      'Index 3: 설정',
      style: kBottomNavigationOptionStyle,
    ),
  ].obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
