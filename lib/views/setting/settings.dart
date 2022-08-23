import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/routine_completed_controller.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';
import 'account_settings.dart';
import 'completed_routines.dart';
import 'routineitem_settings.dart';
import 'service_info.dart';

import '../../controllers/routine_item_setting_controller.dart';

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
        // Container(height: 61.h,
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [SizedBox(width: 56.w,),Text("설정",style: AppleFont22_Black,)],)),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          foregroundColor: black,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              //
            },
          ),
          title: const Text('설정'),
        ),
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
            // kangmin(context, AccountSettingsPage());
            Get.to(AccountSettingsPage());
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
            Get.put(RoutineCompletedController()).getLatestData();
            // kangmin(context, CompletedRoutinesPage());
            Get.to(const CompletedRoutinesPage());
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
          onTap: () {
            RotuineItemSettingController controller =
                Get.put(RotuineItemSettingController());
            controller.onInit();
            Get.to(RoutineItemSettingsPage());
            // kangmin(context, RoutineItemSettingsPage());
          },
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
          trailing: SizedBox(
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
        ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '서비스 안내',
            style: AppleFont22_Black,
          ),
          onTap: () {
            // kangmin(context, const ServiceInfoPage());
            Get.to(ServiceInfoPage());
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
      ],
    );
  }
}

void onPressed() {
  //
}
