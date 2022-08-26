// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/routine_on_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class RoutineLogPage extends StatelessWidget {
  RoutineLogPage({Key? key}) : super(key: key);
  RoutineOnController controller = Get.find<RoutineOnController>();

  @override
  Widget build(BuildContext context) {
    return customBottomSheet(context, Obx(() {
      return Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 45.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.all(0.r),
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (controller.selectedDayIndex.value > 0) {
                    controller.selectedDayIndex - 1;
                    controller.fetchEvent();
                    controller.update();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(
                'Day ${controller.selectedDayIndex.value + 1} ${controller.getSelectedDay()}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(0.r),
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (controller.selectedDayIndex.value <
                      controller.todayIndex.value) {
                    controller.selectedDayIndex + 1;
                    controller.fetchEvent();
                    controller.update();
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          SizedBox(
            height: 33.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: GetBuilder(
                init: controller,
                builder: (context) {
                  return SizedBox(
                    width: 390.w,
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.routineItems.value.length + 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: index == 0
                              ? controller.selectedFilter == index
                                  ? selectedRoutineButton(() {
                                      // controller.selectedFilter = index;
                                      // controller.update();
                                    }, '전체')
                                  : unSelectedRoutineButton(() {
                                      controller.selectedFilter = index;
                                      controller.selectedFilterString = "전체";
                                      controller.update();
                                    }, '전체')
                              : controller.selectedFilter == index
                                  ? selectedRoutineButton(() {
                                      // controller.selectedFilter = index;
                                      // controller.update();
                                    },
                                      '${controller.routineItems.value[index - 1]}')
                                  : unSelectedRoutineButton(() {
                                      controller.selectedFilter = index;
                                      controller.selectedFilterString =
                                          controller
                                              .routineItems.value[index - 1];
                                      
                                      controller.update();
                                    },
                                      '${controller.routineItems.value[index - 1]}'),
                        );
                      },
                    ),
                  );
                }),
          ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 21.w,
          //       ),
          //       selectedRoutineButton(() {}, '전체'),
          //       SizedBox(
          //         width: 16.w,
          //       ),
          //       unSelectedRoutineButton(() {}, '루틴 항목 이름 1'),
          //       SizedBox(
          //         width: 16.w,
          //       ),
          //       unSelectedRoutineButton(() {}, '루틴 항목 이름 2'),
          //       SizedBox(
          //         width: 16.w,
          //       ),
          //       unSelectedRoutineButton(() {}, '루틴 항목 이름 3'),
          //       SizedBox(
          //         width: 21.w,
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 45.h,
          ),
          GetBuilder(
              init: controller,
              builder: (context) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.events.length,
                    // physics: NeverScrollableScrollPhysics(),
                    // physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (isFiltered(index)) {
                        return ListTile(
                          // dense: true,
                          // visualDensity: VisualDensity(vertical: 0),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0.h, horizontal: 16.0.w),
                          leading: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: grey400,
                          ),

                          title: Text('${controller.events[index].name}'),
                          // subtitle: Text('오후 HH : MM'),
                          subtitle: GestureDetector(
                            child: Text(
                              controller.displayDate(
                                  controller.events[index].eventTime),
                              style: AppleFont16_Grey600,
                            ),
                            onTap: (() {
                              // controller
                              controller.selectedEventIndex = index;
                              
                              _showDatePicker(context);
                            }),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // 정말로 수행 기록을 삭제하시겠습니까?
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return deleteEventAlertDialog(() {
                                      //취소
                                      Get.back();
                                    }, () {
                                      //삭제
                                      controller.deleteEvent(index);
                                      Get.back();
                                    });
                                  }));
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      if (isFiltered(index)) {
                        return Container(
                          height: 24,
                          child: OverflowBox(
                            maxHeight: 40,
                            minHeight: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 48,
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                );
              })
        ],
      );
    }));
  }

  bool isFiltered(int index) {
    return (controller.selectedFilterString == "전체" ||
        controller.selectedFilterString == controller.events[index].name);
  }
  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 370,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(), // Have to change this to selected value?
                      onDateTimeChanged: (val) {
                        controller.selectedEventDateTime = val;
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('저장'),
                    onPressed: () {
                      //onPressed
                      controller.changeEvent(
                            controller.selectedEventIndex, controller.firebaseDate(controller.selectedEventDateTime));
                      Get.back();
                    },
                  )
                ],
              ),
            ));
  }
}
