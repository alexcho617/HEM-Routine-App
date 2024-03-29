import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/custom_routine_item_contoller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class CustomRoutineItemPage extends StatelessWidget {
  CustomRoutineItemPage(this.args, {Key? key}) : super(key: key);
  ScreenArguments args;
  CustomRoutineItemController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: background,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[50],
                foregroundColor: Colors.black,
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.delete<CustomRoutineItemController>();
                    Navigator.pop(context);
                  },
                ),
                title: const Text('루틴 항목 직접 만들기'),
                actions: [
                  IconButton(
                      padding: EdgeInsets.only(right: 21.h),
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return routineItemDeleteAlertDialog(() {
                                Get.back();
                              }, () async {
                                if (args.crud == CRUD.update) {
                                  await pageController
                                      .deleteCustomRoutineItem();
                                }
                                Get.back();
                                Get.delete<CustomRoutineItemController>();
                                Get.back();
                              });
                            }));
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: SizedBox(
                  height: 667.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        '루틴 항목',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Form(
                        key: pageController.globalKeys[0],
                        child: TextFormField(
                          controller: pageController.inputController[0],
                          decoration: InputDecoration(
                            suffixIcon: Obx(() => IconButton(
                                  icon: pageController.isValid[0]
                                      ? const Icon(Icons.cancel_outlined)
                                      : const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  onPressed: () {
                                    pageController.inputController[0].clear();
                                    pageController.globalKeys[0].currentState!
                                        .validate();
                                  },
                                )),
                            hintText: '루틴 항목 입력(최대 20자)',
                          ),
                          onChanged: (text) {
                            // do something with text
                            pageController.globalKeys[0].currentState!
                                .validate();
                          },
                          validator: (value) =>
                              pageController.textValidator(value, 0),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        '루틴 항목 설명',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Form(
                        key: pageController.globalKeys[1],
                        child: TextFormField(
                          controller: pageController.inputController[1],
                          decoration: InputDecoration(
                            suffixIcon: Obx(() => IconButton(
                                  icon: pageController.isValid[1]
                                      ? const Icon(Icons.cancel_outlined)
                                      : const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  onPressed: () {
                                    pageController.inputController[1].clear();
                                    pageController.globalKeys[1].currentState!
                                        .validate();
                                  },
                                )),
                            hintText: '루틴 항목 문구 입력(최대 30자)',
                          ),
                          onChanged: (text) {
                            // do something with text
                            pageController.globalKeys[1].currentState!
                                .validate();
                          },
                          validator: (value) =>
                              pageController.textValidator(value, 1),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        '카테고리 선택',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GetBuilder<CustomRoutineItemController>(builder: (_) {
                        return Wrap(
                          children: pageController.makeCategoryButtons(),
                          runSpacing: 8.h,
                          spacing: 16.w,
                        );
                      }),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return (pageController.activateButton[0] &&
                                    pageController.activateButton[1])
                                ? storeButton(() async {
                                    pageController.onSubmitted.value = true;
                                    if (pageController
                                        .globalKeys[0].currentState!
                                        .validate()) {
                                      pageController.beforeBack();
                                      Get.delete<CustomRoutineItemController>();
                                      // kangminBack(context);
                                      Get.back();
                                    }
                                  })
                                : disabledStoreButton(() {});
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 89.h,
                      )
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

  Widget storeButton(VoidCallback? onPressed) {
    return SizedBox(
      width: 335.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          '저장',
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

  Widget disabledStoreButton(VoidCallback? onPressed) {
    return Container(
      width: 335.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 212, 212, 212),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          '저장',
          style: AppleFont14_White,
        ),
      ),
    );
  }
}
