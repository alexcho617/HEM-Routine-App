import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/custom_routine_item_contoller.dart';
import 'package:hem_routine_app/models/routineItem.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/setting/custom_routine_item.dart';

void kangmin(context, Widget page) {
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

void kangminBack(context) {
  int _currentIndex = HomePageState.tabController.index;
  HomePageState.navigatorKeyList[_currentIndex].currentState!.pop(context);
}

void yechan(BuildContext context, int index, Widget page) async {
  int _currentIndex = HomePageState.tabController.index;
  kangminBackUntil(context);
  HomePageState.tabController.index = index;
  // WidgetsBinding.instance.scheduleForcedFrame();
  while (true) {
    if (HomePageState.navigatorKeyList[index].currentContext == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    } else {
      break;
    }
  }

  kangmin(HomePageState.navigatorKeyList[index].currentContext, page);

  //callBack함수를 쓰면 되지 않을까?
}

void kangminBackUntil(BuildContext context) async {
  int _currentIndex = HomePageState.tabController.index;
  while (HomePageState.navigatorKeyList[_currentIndex].currentState!.canPop()) {
    kangminBack(context);
  }
}

Future<void> progressDialog(
  BuildContext context,
  VoidCallback? onPressed,
) async {
  // show the loading dialog
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ),
        );
      });

  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
  onPressed;

  // Close the dialog programmatically
  Navigator.of(context).pop();

void kangminToCustomRoutineItem(ScreenArguments args, context) {
  Get.put(CustomRoutineItemController(args: args));
  kangmin(context, CustomRoutineItemPage(args));

}
