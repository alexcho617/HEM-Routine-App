import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/controllers/report_controller.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/setting/profile_settings.dart';
import 'package:hem_routine_app/views/splash.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../../controllers/login_service.dart';

class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({Key? key}) : super(key: key);
  LoginService loginService = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        customAppBar(context, '계정 설정'),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '프로필 설정',
            style: AppleFont22_Black,
          ),
          onTap: () {
            kangmin(context, ProfileSettingsPage());
          },
          shape: Border(
            bottom: BorderSide(width: 0.8.w, color: grey500),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '로그아웃',
            style: AppleFont22_Black,
          ),
          onTap: (() {
            showDialog(
                context: context,
                builder: ((context) {
                  return signOutAlertDialog(() async {
                    Get.back();
                  }, () {
                    //TODO: 로그아웃 시 컨트롤러 없애기.
                    loginService.signOut();
                    // ReportController _reportController = Get.find();
                    // _reportController.onClose(() {
                    //   print();
                    // });
                    // CalendarController _calendarController = Get.find();
                    // _calendarController.dispose();

                    Get.offAll(() => SplashScreen());
                  });
                }));
          }),
          shape: Border(
            bottom: BorderSide(width: 0.8.w, color: grey500),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings_backup_restore,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '데이터 초기화',
            style: AppleFont22_Black,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return dataAlertDialog(() {
                    Get.back();
                  }, () {
                    loginService.deleteUser();
                    Get.offAll(HomePage());
                  });
                }));
          },
          shape: Border(
            bottom: BorderSide(width: 0.8.w, color: grey500),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.person_remove,
            size: 28.r,
            color: black,
          ),
          title: Text(
            '회원 탈퇴',
            style: AppleFont22_Black,
          ),
          shape: Border(
            bottom: BorderSide(width: 0.8.w, color: grey500),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return withDrawalAlertDialog(() {
                    Get.back();
                  }, (() {
                    loginService.deleteUser();
                    loginService.signOut();
                    Get.offAll(SplashScreen());
                  }));
                }));
          },
        ),
        Container(
          height: 75.h,
          color: Colors.grey[50],
        )
      ],
    );
  }
}

void onPressed() {
  //
}
