import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/setting/account_settings.dart';
import 'package:hem_routine_app/views/setting/completed_routines.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        customAppBar(context, '설정'),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '계정 설정',
            style: AppleFont22_Black,
          ),
          onTap: () {
            kangmin(context, AccountSettingsPage());
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        ListTile(
          leading: Icon(
            Icons.description_outlined,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '내가 수행한 루틴',
            style: AppleFont22_Black,
          ),
          onTap: () {
            kangmin(context, CompletedRoutinesPage());
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        ListTile(
          leading: Icon(
            Icons.edit,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '루틴 항목 관리',
            style: AppleFont22_Black,
          ),
          onTap: onPressed,
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        ListTile(
          leading: Icon(
            Icons.alarm,
            size: 28.r,
            color: black,
          ),
          title: Text(
            'Push 알림 On/Off',
            style: AppleFont22_Black,
          ),
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
          trailing: Container(
            width: 80.w,
            child: FlutterSwitch(
              width: 80.w,
              height: 34.h,
              showOnOff: true,
              activeColor: primary,
              inactiveColor: grey600,
              value: true,
              onToggle: (value) {
                setState(() {
                  print('쿠쿠루삥뽕');
                });
              },
            ),
          ),
          onTap: onPressed,
        ),
      ],
    );
  }
}

void onPressed() {
  //
}
