import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

import '../../utils/constants.dart';

class RoutineEntrySettingPage extends StatefulWidget {
  const RoutineEntrySettingPage({Key? key}) : super(key: key);

  @override
  State<RoutineEntrySettingPage> createState() =>
      _RoutineEntrySettingPageState();
}

class _RoutineEntrySettingPageState extends State<RoutineEntrySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('루틴 항목 설정'),
        ),
        // ListTile(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Get.back();
        //     },
        //   ),
        //   title: Text('루틴 항목 설정'),
        // ),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 43.h,
        ),
        Text(
          '루틴 이름',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'AppleSDGothicNeo'),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          '(기간: 5일간)',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'AppleSDGothicNeo',
              color: grey500),
        ),
        SizedBox(
          height: 69.h,
        ),
        Container(
          height: 105.33.h,
          width: 160.w,
          child: Image.asset('icons/g139087@4x.png'),
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
          height: 50.h,
        ),
        addButton(() {}),
        SizedBox(
          height: 104.h,
        ),
        Container(
          width: 335.w,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {},
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
