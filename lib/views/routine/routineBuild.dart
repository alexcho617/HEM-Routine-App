import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/loginService.dart';
import 'package:hem_routine_app/controller/routineBuildController.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/routine/routineEntrySetting.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

class RoutineBuildPage extends StatelessWidget {
  
  RoutineBuildPage({Key? key}) : super(key: key);

  RoutineBuildController pageController = Get.put(RoutineBuildController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: pageController.globalKey,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar(context, '루틴 항목 설정'),
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
                      
                       GetX<RoutineBuildController>(
                         builder: (_) {
                           return pageController.activateButton.value
                                ? nextButtonBig(() {
                                    pageController.onSubmitted.value = true;
                                    if (pageController.globalKey.currentState!
                                        .validate()) {
                                      kangmin(context, RoutineEntrySettingPage());
                                    }
                                    ;
                                  })
                                : disabledNextButtonBig(() {});
                         }
                       ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
