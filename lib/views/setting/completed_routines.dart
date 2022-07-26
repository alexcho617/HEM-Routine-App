import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hem_routine_app/main.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedRoutinesPage extends StatefulWidget {
  const CompletedRoutinesPage({Key? key}) : super(key: key);

  @override
  State<CompletedRoutinesPage> createState() => _CompletedRoutinesPageState();
}

class _CompletedRoutinesPageState extends State<CompletedRoutinesPage> {
  //List<dynamic> routineList = [];
  List<dynamic> routineList = ["FOR LINT"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: routineList.length == 0
          ? Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: white,
                  foregroundColor: black,
                  centerTitle: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text('내가 수행한 루틴'),
                ),
                Text(
                  '수행한 루틴이 없습니다.',
                  style: AppleFont16_Black,
                ),
                SizedBox(
                  height: 50.h,
                ),
                makeMyRoutineButton(onPressed)
              ],
            )
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: white,
                  foregroundColor: black,
                  centerTitle: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text('내가 수행한 루틴'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 270.w,
                          ),
                          PopupMenuButton(
                            elevation: 10,
                            onSelected: (value) {
                              // TODO : change value ?
                            },
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  height: 32.h,
                                  child: Text(
                                    '이름 순',
                                    style: AppleFont14_Grey600,
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 32.h,
                                  child: Text(
                                    '나이 순',
                                    style: AppleFont14_Grey600,
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 32.h,
                                  child: Text(
                                    '싫은 순',
                                    style: AppleFont14_Grey600,
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 32.h,
                                  child: Text(
                                    '도전 횟수 순',
                                    style: AppleFont14_Grey600,
                                  ),
                                ),
                              ];
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.south_sharp,
                                  size: 18.r,
                                  color: grey600,
                                ),
                                Text(
                                  " 이름 순",
                                  style: AppleFont14_Grey600,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 350.w,
                    height: 680.h,
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return routineCard();
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget routineCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Container(
        width: 349.w,
        height: 79.h,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w,12.h,16.w,8.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$루틴이름",
                      style: AppleFont18_Black,
                    ),
                    Text(
                      "목표 \$n일간",
                      style: AppleFont12_Blue600,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.all(4.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "달성도 \$n%",
                      style: AppleFont14_Grey600,
                    ),
                    satisfaction(3),
                    Text(
                      "도전 횟수 \$n회",
                      style: AppleFont14_Grey600,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget satisfaction(int stars) {
    return Container(
      child: Row(
        children: [
          Text(
            "만족도",
            style: AppleFont14_Grey600,
          ),
          Icon(
            Icons.star,
            size: 14.r,
            color: stars > 0 ? starYellow : grey600,
          ),
          Icon(
            Icons.star,
            size: 14.r,
            color: stars > 1 ? starYellow : grey600,
          ),
          Icon(
            Icons.star,
            size: 14.r,
            color: stars > 2 ? starYellow : grey600,
          ),
          Icon(
            Icons.star,
            size: 14.r,
            color: stars > 3 ? starYellow : grey600,
          ),
          Icon(
            Icons.star,
            size: 14.r,
            color: stars > 4 ? starYellow : grey600,
          ),
        ],
      ),
    );
  }
}

void onPressed() {
  //
}