// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:hem_routine_app/widgets/widgets.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/controllers/routine_off_controller.dart';
import '../views/home.dart';
import 'login_service.dart';
import 'calendar_controller.dart';
import '../models/calendar_event.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class AppStateController extends GetxController {
  Rx<bool> status = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginService loginService = Get.find();
  DateTime now = DateTime.now();
  late String uid;

  //For Rating Logic
  bool? isRated = null;
  Future<bool> isRatedLoaded = Future<bool>.value(false);

  dynamic rateRoutineId;
  dynamic rateRoutineHistoryId;

  dynamic rateRoutineName;
  dynamic rateRoutineDays;
  DateTime rateRoutineHistoryStartDate = DateTime.now();
  DateTime rateRoutineHistoryEndDate = DateTime.now();
  dynamic rateRoutineHistoryComplete;

  dynamic complete = 0.0.obs;

  String getLatestCalendarMessage() {
    CalendarEvent? latestEvent =
        Get.find<CalendarController>().getLatestCalendarEvent();
    if (latestEvent != null) {
      return Get.find<RoutineOffController>().parseRoutineMessage(latestEvent);
    } else {
      return '배변 기록을 추가하세요.';
    }
  }

  @override
  void onInit() async {
    if (loginService.auth.value.currentUser != null) {
      // int _currentIndex = HomePageState.tabController.index;
      uid = loginService.auth.value.currentUser!.uid;
      await isRoutineActive();
      isRatedLoaded = isRatedLoader(await isUserHaveRated(uid));
      // isRated = await isUserHaveRated(uid);
    }

    super.onInit();
  }

  Future<void> isRoutineActive() async {
    // status.value = true;
    await firestore
        .collection('user/$uid/routine')
        .where("isActive", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((document) {
        status.value = true;
      });
    });
    // print('Routine is active');
  }

  Future<bool> isUserHaveRated(String uid) async {
    await firestore
        .collection('user')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      //check isRated
      isRated = await documentSnapshot.get('isRated');
      // print("isUserHaveRated_isRated : $isRated ");
      rateRoutineId = documentSnapshot.get('rateRoutineId');
      rateRoutineHistoryId = documentSnapshot.get('rateRoutineHistoryId');
    }).then((value) async {
      if (isRated == false) {
        await fetchRateRoutine();
      }
    });
    return isRated!;
  }

  Future<bool> isRatedLoader(bool isR) async {
    return true;
  }

  Future<void> setIsRatedTrue() async {
    isRated = true;
    await firestore.collection('user').doc(uid).update({
      'isRated': true,
    });
  }

  Future<void> fetchRateRoutine() async {
    await firestore
        .collection('user')
        .doc(uid)
        .collection('routine')
        .doc(rateRoutineId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      rateRoutineName = documentSnapshot.get('name');
      rateRoutineDays = documentSnapshot.get('days');
    });
    await firestore
        .collection('user')
        .doc(uid)
        .collection('routine')
        .doc(rateRoutineId)
        .collection('routineHistory')
        .doc(rateRoutineHistoryId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      rateRoutineHistoryComplete = documentSnapshot.get('complete');
      rateRoutineHistoryStartDate = documentSnapshot.get('startDate').toDate();
      rateRoutineHistoryEndDate = documentSnapshot.get('endDate').toDate();
    });
  }

  Future<void> showRatingScreen(BuildContext context) async {
    if (isRated == false) {
      showDialog(
        context: context,
        builder: ((context) {
          return routineRateDialog(() {
            // 평가 제출
            // print("selected rank : ${rank.value}");
            rankRoutineHistory();
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  // 피드백 정상적 제출 Alert
                  return feedbackAlertDialog(() {
                    Navigator.pop(context);
                  });
                });
          });
        }),
      );
    } else {
      // Do noting?
    }
  }

  Future<void> rankRoutineHistory() async {
    await setIsRatedTrue();
    await firestore
        .collection('user')
        .doc(uid)
        .collection('routine')
        .doc(rateRoutineId)
        .collection('routineHistory')
        .doc(rateRoutineHistoryId)
        .update({
      'rating': rank.value,
    });
    await setAverageRating();
  }

  Future<void> setAverageRating() async {
    double avgRating = 0.0;
    await firestore
        .collection('user')
        .doc(uid)
        .collection('routine')
        .doc(rateRoutineId)
        .collection('routineHistory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        avgRating += doc.get('rating');
      });
      avgRating /= querySnapshot.size;
    });
    await firestore
        .collection('user')
        .doc(uid)
        .collection('routine')
        .doc(rateRoutineId)
        .update({
      'averageRating': avgRating,
    });
  }

  // Future<void> offRoutine() async {
  //   // await firestore
  //   //     .collection('user/$uid/routine')
  //   //     .where('isActive', isEqualTo: true)
  //   //     .get()
  //   //     .then((QuerySnapshot querySnapshot) {
  //   //   querySnapshot.docs.forEach((doc) async {
  //   //     // Get activeRoutineSnapshot
  //   //     activeRoutineSnapshot = doc;
  //   //     await routinDeactivate();
  //   //     await firestore
  //   //         .collection('user/$uid/routine/${doc.id}/routineHistory')
  //   //         .where('isActive', isEqualTo: true)
  //   //         .get()
  //   //         .then((QuerySnapshot smallQuerySnapshot) {
  //   //       smallQuerySnapshot.docs.forEach((smallDoc) async {
  //   //         // Get activeRoutineHistorySnapshot
  //   //         activeRoutineHistorySnapshot = smallDoc;
  //   //         Map<String, dynamic> data = smallDoc.data() as Map<String, dynamic>;
  //   //         //여기서 startDate를 읽어내서 오늘과 월, 일까지 같다면 삭제.
  //   //         if (data['startDate'] ==
  //   //             Timestamp.fromDate(DateTime(now.year, now.month, now.day))) {
  //   //           routineHistoryDelete();
  //   //         } else {
  //   //           routineHistoryDeactivate();
  //   //         }
  //   //       });
  //   //     });
  //   //   });
  //   // });
  //   status.value = false;
  // }

  RxInt rank = 3.obs;
  Widget routineRateDialog(VoidCallback? onPressed) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      )),
      insetPadding: EdgeInsets.all(0.r),
      titlePadding: EdgeInsets.all(0.r),
      actionsPadding: EdgeInsets.all(0.r),
      contentPadding: EdgeInsets.all(0.r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(height: 36.h),
        Center(
            child: Text(
          '이번 루틴 어떠셨어요?',
          style: AppleFont22_Black,
          textAlign: TextAlign.center,
        )),
        Obx(() {
          return starRankIndicator();
        }),
        Divider(
          indent: 24.w,
          endIndent: 24.h,
          color: grey600,
        ),
        Text("$rateRoutineName", style: AppleFont22_Black),
        SizedBox(
          height: 4.h,
        ),
        Text(
            "(${formatDate(rateRoutineHistoryStartDate)} ~ ${formatDate(rateRoutineHistoryEndDate)})",
            style: AppleFont16_Grey600),
        SizedBox(
          height: 12.h,
        ),
        Text(
            "수행기간: $rateRoutineDays일 | 평균 달성도: ${(complete.value * 100).toStringAsFixed(0)}%",
            style: AppleFont16_Black),
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
              color: primary,
            ),
            width: 312.w,
            height: 56.h,
            child: Center(
              child: Text(
                '평가 제출',
                style: AppleFont16_White,
              ),
            ),
          ),
        )
      ]),
    );
  }

  String formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  Widget starRankIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            starRankSelector(1),
            starRankSelector(2),
            starRankSelector(3),
            starRankSelector(4),
            starRankSelector(5),
          ],
        ),
        Text(
          "${rank.value}점",
          style: AppleFont16_Grey600,
        ),
      ],
    );
  }

  Widget starRankSelector(int i) {
    return GestureDetector(
      onTap: () {
        rank.value = i;
        update();
      },
      child: Builder(builder: (context) {
        if (rank.value >= i) {
          return selectedStar();
        } else {
          return unSelectedStar();
        }
      }),
    );
  }

  Widget selectedStar() {
    return Icon(
      Icons.star,
      size: 40.r,
      color: starYellow,
    );
  }

  Widget unSelectedStar() {
    return Icon(
      Icons.star_outline,
      size: 40.r,
      color: grey600,
    );
  }
}
