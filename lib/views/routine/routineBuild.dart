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
import 'package:hem_routine_app/widgets/widgets.dart';

class RoutineBuildPage extends StatefulWidget {
  const RoutineBuildPage({Key? key}) : super(key: key);

  @override
  State<RoutineBuildPage> createState() => _RoutineBuildPageState();
}

class _RoutineBuildPageState extends State<RoutineBuildPage> {
  RoutineBuildController pageController = Get.put(RoutineBuildController());

  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: pageController.globalKey,
      child: Column(
        children: [
          customAppBar(context, '루틴 항목 설정'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
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
                SizedBox(
                  height: 48.h,
                ),
                Text(
                  '루틴 수행 기간',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 139.h,
                  child: CupertinoPicker(
                    children: pageController.routinePeriod,
                    onSelectedItemChanged: (value) {},
                    itemExtent: 25.h,
                  ),
                ),
                SizedBox(
                  height: 210.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => pageController.activateButton.value
                          ? nextButtonBig(() {
                            pageController.onSubmitted.value = true;
                            pageController.globalKey.currentState!.validate();
                          })
                          : disabledNextButtonBig(() {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
