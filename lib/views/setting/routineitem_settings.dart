import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class RoutineItemSettingsPage extends StatelessWidget {
  const RoutineItemSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List routineItems = [];
    return Container(
      color: Colors.grey[50],
      child: routineItems.isEmpty?
      Column(
        children: [
          customAppBar(context, '루틴 항목 관리'),
          SizedBox(height: 170.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 115.w),
            child: Image.asset('assets/appIcon.png'),
          ),
          SizedBox(
            height: 45.h,
          ),
          Text('등록된 루틴항목이 없습니다.',style: AppleFont16_Black,)
        ],
      )
      :
      Column(
        children: [
          customAppBar(context, '루틴 항목 관리'),
        ],
      )
    );
  }
}
