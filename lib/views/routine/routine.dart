import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controllers/login_service.dart';
import '../../controllers/routine_off_controller.dart';
import '../../controllers/routine_on_controller.dart';
import '../../controllers/app_state_controller.dart';
import '../../utils/functions.dart';
import '../home.dart';
import 'routine_build.dart';
import '../bottom_pop_up/routine_log.dart';
import '../setting/routine_detail.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class RoutinePage extends StatelessWidget {
  RoutinePage({Key? key}) : super(key: key);
  AppStateController appStateController = Get.find();
  LoginService loginService = Get.find();
  RoutineOnController onController = Get.put(RoutineOnController());
  RoutineOffController offController = Get.put(RoutineOffController());
  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 32.h,
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
              FlutterSwitch(
                width: 68.w,
                height: 29.h,
                showOnOff: true,
                activeColor: primary,
                inactiveColor: grey600,
                value: appStateController.status.value,
                onToggle: (value) {
                  if (appStateController.status.value) {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return routineStopAlertDialog(() {
                            //취소
                            Navigator.pop(context);
                          }, () async {
                            // 중단
                            // Navigator.pop(context);
                            if (onController.isTodayFirstDay) {
                              // Today
                              onController.offRoutineToday();
                              Navigator.pop(context);
                            } else {
                              // NOT Today
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
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
                              await onController.offRoutineNotToday();
                              Get.back();

                              await appStateController.showRatingScreen(
                                  HomePageState.scaffoldKey.currentContext!);
                              await Get.find<RoutineOffController>()
                                  .getRoutineList();
                            }
                          });
                        }));
                  }
                },
              ),
            ],
          ),
          appStateController.status.value
              ? //WHEN ON
              onController.selectedDayIndex.value != -99
                  ? Column(
                      children: [
                        SizedBox(
                          height: 19.h,
                        ),
                        Text(
                          onController.name.value,
                          style: AppleFont24_Black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: GetBuilder<RoutineOnController>(
                              builder: (context) {
                            return dayPicker(
                                onController.selectedDayIndex.value,
                                onController.days.value,
                                onController.todayIndex.value);
                          }),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 225.w,
                                  height: 116.h,
                                ),
                                SizedBox(
                                  height: 380.h,
                                  child: SingleChildScrollView(
                                    child: Obx(() {
                                      if (onController
                                          .currentCount.value.isEmpty) {
                                        return SizedBox(
                                          width: 50.w,
                                          height: 50.h,
                                          child:
                                              const CircularProgressIndicator(),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: 390.w,
                                          height: 1000.h,
                                          child: routineItemList(),
                                        );
                                      }
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                  context: context
                                      .findAncestorStateOfType<HomePageState>()!
                                      .context,
                                  expand: false,
                                  builder: (context) {
                                    onController.fetchEvent();
                                    return RoutineLogPage();
                                  },
                                );
                              },
                              child: GetBuilder<RoutineOnController>(
                                  builder: (context) {
                                return halfCircluarGuage(
                                    onController.dayCompletes[
                                        onController.selectedDayIndex.value]);
                              }),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const CircularProgressIndicator()
              : // WHEN OFF
              Column(
                  children: [
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
                      appStateController.getLatestCalendarMessage(),
                      style: AppleFont12_Black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
                    makeMyRoutineButton(() {
                      RoutineOffController controller =
                          Get.put(RoutineOffController());
                      controller.initValues();
                      kangmin(context, RoutineBuildPage());
                    }),
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
                          GetBuilder<RoutineOffController>(builder: (context) {
                            return SizedBox(
                              width: 392.w,
                              height: 200.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: offController.routines.length > 10
                                    ? 10
                                    : offController.routines.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return routineCard(
                                      offController.routines[i].name,
                                      offController.routines[i].days,
                                      offController.routines[i].averageComplete,
                                      offController.routines[i].averageRating,
                                      () {
                                    // yechan(
                                    //     context,
                                    //     3,
                                    //     RoutineDetailPage(
                                    //         uid: offController
                                    //             .routines[i].id));
                                    Get.to(RoutineDetailPage(
                                        uid: offController.routines[i].id));
                                  });
                                },
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget dayPicker(int focusedDay, int itemCount, int today) {
    return SizedBox(
      width: itemCount * 76.w + 18.w,
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: InkWell(
              splashColor: Colors.transparent,
              key: Key('$index'),
              onTap: () {
                if (index <= today) {
                  onController.selectedDayIndex.value = index;
                  onController.getCurrCount();
                }

              },
              child: Ink(
                child: Column(
                  children: [
                    Text(
                      'Day ${index + 1}',
                      style: index == focusedDay
                          ? AppleFont22_Blue600
                          : AppleFont16_Black,
                    ),
                    index <= today
                        ? GetBuilder<RoutineOnController>(builder: (context) {
                            return Text(
                              '${(onController.dayCompletes.value[index] * 100).round()} %',
                              style: index == focusedDay
                                  ? AppleFont11_Blue600
                                  : AppleFont11_Grey700,
                            );
                          })
                        : const Text(""),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget routineItemList() {
    int itemLength = onController.routineItems.length;
    return ReorderableListView.builder(
      padding: EdgeInsets.all(10.r),
      proxyDecorator: ((child, index, animation) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.transparent,
            )),
            child: child,
          ),
        );
      }),
      itemBuilder: (BuildContext context, int index) {
        // double percent = controller.getPercent(controller.countList[index],
        //     controller.routineItems[index].goalCount);
        return Container(
          key: Key('$index'),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: PhysicalModel(
            color: white,
            elevation: 5.r,
            borderRadius: BorderRadius.circular(12.r),
            child: ListTile(
              shape: RoundedRectangleBorder(
                // side: BorderSide(
                //   color: Colors.black,
                //   width: 1.r,
                // ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              leading: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: const Icon(Icons.menu),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              horizontalTitleGap: 0,
              minVerticalPadding: 22.w,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      onController.routineItems[index],
                      style: AppleFont18_Black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '수행/목표',
                        style: AppleFont14_Grey600,
                      ),
                      Text(
                        '${onController.currentCount[index]}/${onController.goals[index]}',
                        style: AppleFont14_Grey600,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
              trailing: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 46.w,
                    height: 46.h,
                    child: circluarGuage(onController.getPercent(
                        onController.currentCount.value[index],
                        onController.goals.value[index])),
                  ),
                  Obx(() {
                    return SizedBox(
                      width: 34.w,
                      height: 34.h,
                      child: onController.isFinished.value
                          ? GetBuilder<RoutineOnController>(builder: (context) {
                              return InkWell(
                                onTap: () async {
                                  return onController.onPlusPressed(index);
                                },
                                child: Ink(
                                  child: CircleAvatar(
                                    backgroundColor: blue600,
                                    child: Icon(
                                      Icons.add,
                                      color: grey50,
                                    ),
                                  ),
                                ),
                              );
                            })
                          : const CircularProgressIndicator(),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: itemLength,
      onReorder: (int oldIndex, int newIndex) {
        onController.itemReorder(oldIndex, newIndex);
      },
    );
  }
}
