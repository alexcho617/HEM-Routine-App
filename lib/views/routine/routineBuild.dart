import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/routine/routineEntitySetting.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

class RoutineBuildPage extends StatelessWidget {
  RoutineBuildPage({Key? key}) : super(key: key);

  RoutineOffController pageController = Get.put(RoutineOffController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Form(
        key: pageController.globalKey,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.grey[50],
              foregroundColor: Colors.black,
              centerTitle: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  pageController.inputController.clear();
                  pageController.isValid.value = true;
                  pageController.activateButton.value = false;
                },
              ),
              title: Text('루틴 설계'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                height: 583.h,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      '루틴 이름',
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: pageController.inputController,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => IconButton(
                              icon: pageController.isValid.value
                                  ? Icon(Icons.cancel_outlined)
                                  : Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                pageController.inputController.clear();
                                pageController.globalKey.currentState!.validate();
                              },
                            )),
                        hintText: '루틴 이름 입력(최대 20자)',
                      ),
                      onChanged: (text) {
                        // do something with text
                        pageController.globalKey.currentState!.validate();
                      },
                      validator: (value) => pageController.textValidator(value),
                    ),
                    // SizedBox(
                    //   height: 48.h,
                    // ),
                    Expanded(child: Container()),
                    Text(
                      '루틴 수행 기간',
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 139.h,
                      child: CupertinoPicker(
                        children: pageController.routinePeriod,
                        onSelectedItemChanged: (value) {
                          // print(value);
                          pageController.routinePeriodIndex.value = value + 1;
                        },
                        itemExtent: 25.h,
                      ),
                    ),
                    SizedBox(
                      height: 210.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetX<RoutineOffController>(builder: (_) {
                          return pageController.activateButton.value
                              ? nextButtonBig(() {
                                  pageController.onSubmitted.value = true;
                                  if (pageController.globalKey.currentState!
                                      .validate()) {
                                    kangmin(context, RoutineEntitySettingPage());
                                  }
                                })
                              : disabledNextButtonBig(() {});
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
