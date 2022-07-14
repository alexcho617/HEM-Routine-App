import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 79.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Routine',
                style: AppleFont16_Grey600,
              ),
              SizedBox(
                width: 11.w,
              ),
              Container(
                width: 68.w,
                height: 29.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: grey500,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: grey600,
                      size: 18.r,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'OFF',
                      style: AppleFont16_Grey600,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 19.h,
          ),
          Text(
            '루틴 도전',
            style: AppleFont24_Black,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            '배가 많이 불편하신가요?\n \$사용자님에게 맞는 루틴을 만들어라',
            style: AppleFont12_Black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 43.h,
          ),
          makeMyRoutineButton(onPressed),
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.all(31.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Text(
                    '지난 나의 루틴',
                    style: AppleFont16_Black,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      routineCard('루틴이름 1', 7, 80, 3, onPressed),
                      routineCard('루틴이름 2', 7, 80, 3, onPressed),
                      routineCard('루틴이름 3', 7, 80, 3, onPressed),
                    ],
                  ),
                ),
              ],
            ),
          ),
          plusSquareButton(onPressed),
        ],
      ),
    );
  }

  void onPressed() {
    //void onPressed
  }
}
