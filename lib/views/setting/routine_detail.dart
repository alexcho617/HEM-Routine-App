import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineDetailPage extends StatelessWidget {
  const RoutineDetailPage({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: white,
          child: Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                centerTitle: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('루틴 상세보기'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return routineDeleteAlertDialog(
                            () {
                              //취소
                              Get.back();
                            },
                            (() {
                              //TODO : 삭제
                              Get.back();
                            }),
                          );
                        }),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
              SizedBox(
                height: 44.h,
              ),
              Text(
                "\$루틴이름$index",
                style: AppleFont24_Black,
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                "(목표 수행 기간: 7일간)",
                style: AppleFont16_Grey600,
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                color: blue50,
                width: 350.w,
                height: 85.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "도전 횟수",
                            style: AppleFont14_Black,
                          ),
                          Text(
                            "평균 달성도",
                            style: AppleFont14_Black,
                          ),
                          Text(
                            "평균 만족도",
                            style: AppleFont14_Black,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$회",
                            style: AppleFont22_Blue600,
                          ),
                          Text(
                            "\$\$%",
                            style: AppleFont22_Blue600,
                          ),
                          Text(
                            "\$.\$점",
                            style: AppleFont22_Blue600,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "루틴 항목 구성",
                            style: AppleFont16_Black01,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 381.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: ((context, index) {
                            return routineItemCard("루틴 항목", index);
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 66.h,
          right: 27.w,
          child: routineButton(
            () {
              // 루틴 변경
              showDialog(
                context: context,
                builder: ((context) {
                  return routineCopyAlertDialog(() {
                    //취소
                    Get.back();
                  }, () {
                    // TODO :신규 루틴 생성 페이지
                    Get.back();
                  });
                }),
              );
            },
            () {
              // 루틴 다시 도전!
              showDialog(
                context: context,
                builder: ((context) {
                  return routineRestartAlertDialog(() {
                    //취소
                    Get.back();
                  }, () {
                    // TODO: 루틴 시작
                    Get.back();
                  });
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  void onPressed() {
    //
  }
}
