// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controllers/routine_entity_controller.dart';
import '../../controllers/routine_off_controller.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/controllers/routine_on_controller.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/bottom_pop_up/routine_item_add.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

import '../../utils/constants.dart';

// ignore: must_be_immutable
class RoutineEntitySettingPage extends StatelessWidget {
  RoutineEntitySettingPage({Key? key}) : super(key: key);

  RoutineEntityController routineEntityController =
      Get.put(RoutineEntityController());
  RoutineOffController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          height: 745.h,
          color: Colors.grey[50],
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customAppBar(context, '루틴 항목 설정'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 43.h,
                  ),
                  Text(
                    '${pageController.inputController.text}',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'AppleSDGothicNeo'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '(기간: ${pageController.routinePeriodIndex.value}일간)',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'AppleSDGothicNeo',
                        color: grey500),
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  GetBuilder<RoutineEntityController>(builder: (_) {
                    return routineEntityController.addedRoutineItemCount == 0
                        ? Column(
                            children: [
                              SizedBox(
                                height: 36.h,
                              ),
                              SizedBox(
                                height: 105.33.h,
                                width: 160.w,
                                child: Image.asset('assets/appIcon.png'),
                              ),
                              SizedBox(
                                height: 45.67.h,
                              ),
                              Text(
                                '루틴 항목을 추가해주세요.',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'AppleSDGothicNeo',
                                ),
                              ),
                              SizedBox(
                                height: 202.h,
                              ),
                              SizedBox(
                                width: 335.w,
                                height: 48.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '이전',
                                    style: AppleFont14_Grey700,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    primary: const Color.fromARGB(
                                        255, 212, 212, 212),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 5.h,
                                color: Colors.grey[50],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 22.w,
                                  ),
                                  const Text('루틴 항목 추가'),
                                ],
                              ),
                              SingleChildScrollView(
                                  child: SizedBox(
                                height: 347.h,
                                child:
                                    addRoutineItemList(routineEntityController),
                              )),
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 28.w),
                                child: storeRoutineButton(() async {
                                  Navigator.pop(context);
                                }, () async {
                                  // <<<<<<< HEAD
                                  if (routineEntityController
                                      .validateGoalCount()) {
                                    await routineEntityController.addRoutine();
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return saveAlertDialog(() {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return routineStartAlertDialog(
                                                      () async {
                                                    Get.delete<
                                                        RoutineEntityController>();
                                                    pageController.initValues();
                                                    Navigator.pop(context);
                                                    kangminBackUntil(context);
                                                  }, () async {
                                                    await _fetchData(context);
                                                    Navigator.pop(context);
                                                    kangminBackUntil(context);
                                                  });
                                                });
                                          });
                                        }));
                                    await Get.find<RoutineOffController>()
                                        .getRoutineList();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return goalCountAlertDialog(() {
                                            Navigator.pop(context);
                                          });
                                        }));
                                  }
                                }),
                              ),
                            ],
                          );
                  }),
                ],
              ),
              Positioned(
                child: addButton(() {
                  showCupertinoModalBottomSheet(
                    context: context
                        .findAncestorStateOfType<HomePageState>()!
                        .context,
                    expand: false,
                    builder: (context) => RoutineItemAddPage(),
                  );
                  pageController.initRoutineItemsValue();
                }),
                bottom: 241.h,
                right: 95.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customAppBar(context, String name) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[50],
      foregroundColor: black,
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
          Get.delete<RoutineEntityController>();
          pageController.initValues();
        },
      ),
      title: Text(name),
    );
  }

  Widget storeRoutineButton(
      VoidCallback? onPressedBack, VoidCallback onPressedNext) {
    return SizedBox(
      width: 335.w,
      height: 48.h,
      child: Row(
        children: [
          backButtonSmall(onPressedBack),
          SizedBox(
            width: 24.w,
          ),
          storeSmall(onPressedNext),
        ],
      ),
    );
  }

  Widget storeSmall(VoidCallback? onPressed) {
    return SizedBox(
      width: 204.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          '루틴 저장',
          style: AppleFont14_White,
        ),
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await routineEntityController.startRoutine();
    Get.find<AppStateController>().status.value = true;
    Get.delete<RoutineEntityController>();
    pageController.initValues();
    await Get.find<RoutineOnController>().getRoutineData();
    await Get.find<RoutineOnController>().getRoutineHistoryData();

    // Close the dialog programmatically
    Navigator.of(context).pop();
  }
}
