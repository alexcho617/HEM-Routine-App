import 'package:flutter/material.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/routine/routineBuild.dart';
import 'package:hem_routine_app/views/setting/routine_detail.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/routine_completed_controller.dart.dart';

class CompletedRoutinesPage extends StatefulWidget {
  const CompletedRoutinesPage({Key? key}) : super(key: key);

  @override
  State<CompletedRoutinesPage> createState() => _CompletedRoutinesPageState();
}

class _CompletedRoutinesPageState extends State<CompletedRoutinesPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RoutineCompletedController());
    return Obx(() {
      return Container(
        color: background,
        child: controller.routines.isEmpty
            ? Column(
                children: [
                  customAppBar(context, '내가 수행한 루틴'),
                  SizedBox(
                    height: 170.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 115.w),
                    child: Image.asset('assets/appIcon.png'),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Text(
                    '수행한 루틴이 없습니다.',
                    style: AppleFont16_Black,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  makeMyRoutineButton(() {
                    //나만의 쾌변 루틴 만들기
                    //TODO : Navigate tp 5-3-1
                    kangmin(context, RoutineBuildPage());
                  })
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customAppBar(context, '내가 수행한 루틴'),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              elevation: 10,
                              onSelected: (value) {
                                controller.sorting.value = value.toString();
                                if (controller.sorting.value == "이름 순") {
                                  controller.sortByName();
                                } else if (controller.sorting.value ==
                                    "만족도 순") {
                                  controller.sortByRank();
                                } else if (controller.sorting.value ==
                                    "달성도 순") {
                                  controller.sortByCompleted();
                                } else if (controller.sorting.value ==
                                    "도전 횟수 순") {
                                  controller.sortByTry();
                                }
                              },
                              shape: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
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
                                    value: "이름 순",
                                  ),
                                  PopupMenuItem(
                                    height: 32.h,
                                    child: Text(
                                      '만족도 순',
                                      style: AppleFont14_Grey600,
                                    ),
                                    value: "만족도 순",
                                  ),
                                  PopupMenuItem(
                                    height: 32.h,
                                    child: Text(
                                      '달성도 순',
                                      style: AppleFont14_Grey600,
                                    ),
                                    value: "달성도 순",
                                  ),
                                  PopupMenuItem(
                                    height: 32.h,
                                    child: Text(
                                      '도전 횟수 순',
                                      style: AppleFont14_Grey600,
                                    ),
                                    value: "도전 횟수 순",
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
                                    " ${controller.sorting.value}",
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
                      height: 609.h,
                      child: ListView.builder(
                        itemCount: controller.routines.length,
                        itemBuilder: (BuildContext context, int index) {
                          return routineCard(
                              controller.routines[index].name,
                              controller.routines[index].averageComplete,
                              controller.routines[index].averageRating,
                              controller.routines[index].tryCount,
                              controller.routines[index].days,
                              controller.routines[index].uid,
                              );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Widget routineCard(String name, int complete, double rating, int tryCount,
      int days, String uid) {
    return InkWell(
      onTap: () {
        kangmin(context, RoutineDetailPage(uid: uid));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: SizedBox(
          width: 349.w,
          height: 79.h,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: AppleFont18_Black,
                      ),
                      Text(
                        "목표 $days일간",
                        style: AppleFont12_Blue600,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "달성도 $complete%",
                        style: AppleFont14_Grey600,
                      ),
                      satisfaction(rating),
                      Text(
                        "도전 횟수 $tryCount회",
                        style: AppleFont14_Grey600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget satisfaction(double stars) {
    return Row(
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
    );
  }
}

void onPressed() {
  //
}
