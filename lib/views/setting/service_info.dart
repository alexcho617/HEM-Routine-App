import 'package:flutter/material.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class ServiceInfoPage extends StatefulWidget {
  const ServiceInfoPage({Key? key}) : super(key: key);

  @override
  State<ServiceInfoPage> createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState extends State<ServiceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppBar(context, '서비스 안내'),
        ListTile(
          title: Text(
            '서비스 이용약관',
            style: AppleFont22_Black,
          ),
          onTap: () {
            //
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        ListTile(
          title: Text(
            '개인 정보 처리 방침',
            style: AppleFont22_Black,
          ),
          onTap: () {
            //
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        Container(
          width: 390.w,
          height: 526.h,
          color: white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("회사 소개",
            style: AppleFont22_Black,
            ),
            Text("상호"),
            Text("회사명"),
            ],
          ),
        )
      ],
    );
  }
}
