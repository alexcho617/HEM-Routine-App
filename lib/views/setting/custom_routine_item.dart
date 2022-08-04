import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/custom_routine_item_contoller.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';

class CustomRoutineItemPage extends StatelessWidget {
  CustomRoutineItemPage({Key? key}) : super(key: key);
  CustomRoutineItemController pageController = Get.put(CustomRoutineItemController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: 
        Column(
          // mainAxisSize: MainAxisSize.max,
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
                },
              ),
              title: Text('루틴 설계'),
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
                                // pageController.globalKey.currentState!.validate();
                              },
                            )),
                        hintText: '루틴 항목 입력(최대 20자)',
                      ),
                      onChanged: (text) {
                        // do something with text
                        // pageController.globalKey.currentState!.validate();
                      },
                      // validator: (value) => pageController.textValidator(value),
                    ),
                    // SizedBox(
                    //   height: 48.h,
                    // ),
                    SizedBox(height: 40.h,),
                    Text(
                      '루틴 항목 설명',
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
                                // pageController.globalKey.currentState!.validate();
                              },
                            )),
                        hintText: '루틴 항목 문구 입력(최대 30자)',
                      ),
                      onChanged: (text) {
                        // do something with text
                        // pageController.globalKey.currentState!.validate();
                      },
                      // validator: (value) => pageController.textValidator(value),
                    ),
                    SizedBox(height: 40.h,),
                    Text(
                      '카테고리 선택',
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.h,),
                    GetBuilder<CustomRoutineItemController>(
                      builder: (_) {
                        return Wrap(children: pageController.makeCategoryButtons(), runSpacing: 8.h, spacing: 16.w,);
                      }
                    ),
                    Expanded(child: Container()), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return pageController.activateButton.value
                              ? storeButton(() {
                                  // pageController.onSubmitted.value = true;
                                  // if (pageController.globalKey.currentState!
                                  //     .validate()) {
                                    // kangmin(context, RoutineEntitySettingPage());
                                  // }
                                })
                              : disabledStoreButton(() {});
                        }),
                      ],
                    ),
                    SizedBox(height: 89.h,)
                  ],
                ),
              ),
            ),
          ],
        ),
      
    );
  }

  Widget storeButton(VoidCallback? onPressed) {
  return Container(
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
      color: Color.fromARGB(255, 212, 212, 212),
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


