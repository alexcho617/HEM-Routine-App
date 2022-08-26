import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/routine_off_controller.dart';
import '../../utils/functions.dart';
import 'routine_entity_setting.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class RoutineBuildPage extends StatelessWidget {
  RoutineBuildPage({Key? key}) : super(key: key);

  RoutineOffController pageController = Get.put(RoutineOffController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[50],
        child: Form(
          key: pageController.globalKey,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              customAppBar(context, '루틴설계'),
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
                                    ? const Icon(Icons.cancel_outlined)
                                    : const Icon(
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
                      SizedBox(
                        height: 139.h,
                        child: CupertinoPicker(
                          children: RoutineOffController.routinePeriod,
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
      ),
    );
  }
}
