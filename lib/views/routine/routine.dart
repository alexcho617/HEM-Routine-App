import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routine_on_controller.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/routine/routineBuild.dart';
import 'package:hem_routine_app/views/routine/routineEntitySetting.dart';
import 'package:hem_routine_app/views/bottom_pop_up/routineLog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class RoutinePage extends StatelessWidget {
  RoutinePage({Key? key}) : super(key: key);
  AppStateController appStateController = Get.find();
  LoginService loginService = Get.find();
  RoutineOnController controller = Get.find<RoutineOnController>();
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
                            Get.back();
                          }, () {
                            // 중단
                            Get.back();
                            Get.find<AppStateController>().offRoutine();
                          });
                        }));
                  }
                },
              ),
            ],
          ),
          appStateController.status.value
              ? Column(
                  children: [
                    SizedBox(
                      height: 19.h,
                    ),
                    Text(
                      controller.name.value,
                      style: AppleFont24_Black,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.r),
                      child: dayPicker(controller.selectedDayIndex.value,
                          controller.days.value, controller.todayIndex.value),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              
                              onTap: () {
                                print("ONTAP");
                                showCupertinoModalBottomSheet(
                                  context: context
                                      .findAncestorStateOfType<HomePageState>()!
                                      .context,
                                  expand: false,
                                  builder: (context) => RoutineLogPage(),
                                );
                              },
                              child: Container(
                                width: 225.w,
                                height: 116.h,
                              ),
                            ),
                            SizedBox(
                              height: 308.h,
                              child: SingleChildScrollView(
                                child: Container(
                                    width: 390.w,
                                    height: 400.h,
                                    child: Obx(() {
                                      return routineItemList();
                                    })),
                              ),
                            ),
                          ],
                        ),
                        halfCircluarGuage(0.75),
                      ],
                    ),
                  ],
                )
              : Column(
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
                      '배가 많이 불편하신가요?\n ${loginService.name.value}님에게 맞는 루틴을 만들어 보세요!',
                      style: AppleFont12_Black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
                    makeMyRoutineButton(() {
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
                  ],
                ),
        ],
      ),
    );
  }

  void onPressed() {
    //void onPressed
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
                if (index <= today) controller.selectedDayIndex.value = index;
                // print("focused day : $focusedDay   today : $today");
                // } else {
                //   // print("Clicked out of date!");
                // }
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
                        ? Text(
                            'xxx',
                            style: index == focusedDay
                                ? AppleFont11_Blue600
                                : AppleFont11_Grey700,
                          )
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
    int itemLength = controller.routineItems.length;
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
                child: Icon(Icons.menu),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              horizontalTitleGap: 0,
              minVerticalPadding: 22.w,
              title: SizedBox(
                height: 36.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.routineItems[index],
                      style: AppleFont18_Black,
                    ),
                    Column(
                      children: [
                        Text(
                          '수행/목표',
                          style: AppleFont14_Grey600,
                        ),
                        Text(
                          '1/${controller.goals[index]}', // TODO : current Count
                          style: AppleFont14_Grey600,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
              ),
              trailing: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 46.w,
                    height: 46.h,
                    child: circluarGuage(controller.getPercent(1,
                        controller.goals[index])), //TODO: change to curr cont
                  ),
                  Container(
                    width: 34.w,
                    height: 34.h,
                    child: InkWell(
                      onTap: () => controller.onPlusPressed(),
                      child: Ink(
                        child: CircleAvatar(
                          backgroundColor: blue600,
                          child: Icon(
                            Icons.add,
                            color: grey50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: itemLength,
      onReorder: (int oldIndex, int newIndex) {
        controller.itemReorder(oldIndex, newIndex);
      },
    );
  }
}
