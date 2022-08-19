import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/routine_detail_controller.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/routine/routine.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineDetailPage extends StatefulWidget {
  RoutineDetailPage({super.key, required this.uid});
  dynamic uid;

  @override
  State<RoutineDetailPage> createState() => _RoutineDetailPageState();
}

class _RoutineDetailPageState extends State<RoutineDetailPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RoutineDetailController(id: widget.uid));
    return Stack(
      children: [
        Obx(() {
          return Container(
            color: background,
            child: Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: background,
                  foregroundColor: Colors.black,
                  centerTitle: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.delete<RoutineDetailController>();
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
                                //삭제
                                controller.deleteDoc();
                                Get.back();
                                kangminBack(context);
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
                  controller.name.value,
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
                              "${controller.tryCount}회",
                              style: AppleFont22_Blue600,
                            ),
                            Text(
                              "${(controller.averageComplete.value * 100).round().toString()}%",
                              style: AppleFont22_Blue600,
                            ),
                            Text(
                              "${num.parse(controller.averageRating.value.toStringAsFixed(1))}점",
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
                            itemCount: controller.routineItem.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onLongPress: () {
                                  controller.isTapped[index] = true;
                                  controller.update();
                                },
                                onLongPressUp: () {
                                  controller.isTapped[index] = false;
                                  controller.update();
                                },
                                child: GetBuilder<RoutineDetailController>(
                                    builder: (context) {
                                  return routineItemCard(
                                    controller.routineItem[index],
                                    controller.goals[index],
                                    controller.isTapped[index],
                                  );
                                }),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
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
                    // 신규 루틴 생성
                    // TODO : Navigate to 5-3-1 and make new routine and load previous routine info and routine
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
                    // 루틴 시작
                    Get.back();
                    controller.fetchData(context);
                    
                    yechan(context, 1, RoutinePage());
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
