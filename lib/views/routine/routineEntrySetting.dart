import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/routineEntityController.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/bottom_pop_up/routine_item_add.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../utils/constants.dart';

class RoutineEntrySettingPage extends StatefulWidget {
  const RoutineEntrySettingPage({Key? key}) : super(key: key);

  @override
  State<RoutineEntrySettingPage> createState() =>
      _RoutineEntrySettingPageState();
}

class _RoutineEntrySettingPageState extends State<RoutineEntrySettingPage> {
  RoutineEntityController routineEntityController =
      Get.put(RoutineEntityController());
  RoutineOffController pageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
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
          '(기간: ${pageController.routinePeriodIndex.value+1}일간)',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'AppleSDGothicNeo',
              color: grey500),
        ),
        SizedBox(
          height: 69.h,
        ),
        // routineEntityController.addedRoutineItemCount == 0?
        Container(
          height: 105.33.h,
          width: 160.w,
          child: Image.asset('icons/g139087@4x.png'),
        ),
        // :addRoutineItemList(routineEntityController),
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
          height: 50.h,
        ),
        addButton(() {
          showCupertinoModalBottomSheet(
                        context: context
                            .findAncestorStateOfType<HomePageState>()!
                            .context,
                        expand: false,
                        builder: (context) => RoutineItemAddPage(),
                      );
          pageController.initRoutineItemsValue();
        }),
        SizedBox(
          height: 104.h,
        ),
        Container(
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
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Color.fromARGB(255, 212, 212, 212),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        )
      ],
    );
  }
}
