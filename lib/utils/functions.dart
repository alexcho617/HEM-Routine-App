import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/custom_routine_item_contoller.dart';
import 'package:hem_routine_app/models/routineItem.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/setting/custom_routine_item.dart';

void kangmin(context, Widget page) {//push하는 함수. 기본 push에 애니메이션 효과를 추가하였다.
// 기본적으로는 Navigator.push(context, MaterialPageRoute(builder: (context) => const Page4()));
////이런 식으로 push를 해도 되는데 화면 뒤에 잔상이 남는 것 같아서 다음과 같은 함수를 적용하여 push를 구현하였다.
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.elasticIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  ).then((_) {
    //
  });
}

void kangminBack(context) {//뒤로 가기인데 현재 탭에서 뒤로 가기이다. 그냥 pop을 하면 전체화면이 없어질 수 있다.
  int _currentIndex = HomePageState.tabController.index;
  HomePageState.navigatorKeyList[_currentIndex].currentState!.pop(context);
}

void yechan(BuildContext context, int indexToSwitch, Widget page) async {//현재 보고 있는 page를 모두 pop하고 다른 page로 전환할 때 쓰는 함수
  int _currentIndex = HomePageState.tabController.index;
  kangminBackUntil(context);
  
  HomePageState.tabController.index = indexToSwitch;
  // WidgetsBinding.instance.scheduleForcedFrame();
  while (true) {
    if (HomePageState.navigatorKeyList[indexToSwitch].currentContext == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    } else {
      break;
    }
  }

  kangmin(HomePageState.navigatorKeyList[indexToSwitch].currentContext, page);

  //callBack함수를 쓰면 되지 않을까?
}

void kangminBackUntil(BuildContext context) async {//현재 보고 있는 tab의 모든 stack을 다 빠져나가는 함수 popUntil을 대신해서 만들었다.
  int _currentIndex = HomePageState.tabController.index;
  while (HomePageState.navigatorKeyList[_currentIndex].currentState!.canPop()) {
    kangminBack(context);
  }
}

void kangminToCustomRoutineItem(ScreenArguments args, context) {
  Get.put(CustomRoutineItemController(args: args));
  kangmin(context, CustomRoutineItemPage(args));
}
