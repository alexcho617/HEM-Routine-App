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
  RoutineOnController controller = Get.put(RoutineOnController());
  int dayStatus = 3;

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
                      appStateController.name.value,
                      style: AppleFont24_Black,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.r),
                      child: DayPicker(dayStatus - 1, 14),
                    ),
                    InkWell(
                      child: halfCircluarGuage(0.75),
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context
                              .findAncestorStateOfType<HomePageState>()!
                              .context,
                          expand: false,
                          builder: (context) => RoutineLogPage(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 308.h,
                      child: OverflowBox(
                        minHeight: 500.h,
                        maxHeight: 500.h,
                        child: SingleChildScrollView(
                          child: Container(
                              height: 400.h, child: routineItemList()),
                        ),
                      ),
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

  Widget DayPicker(int focusedDay, int itemCount) {
    return Container(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: InkWell(
              key: Key('$index'),
              onTap: () {
                // setState(() {
                //   dayStatus = index + 1;
                // });
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
                    Text(
                      '${index * 10}%',
                      style: index == focusedDay
                          ? AppleFont11_Blue600
                          : AppleFont11_Grey700,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
