import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/views/setting/profile_settings.dart';
import 'package:hem_routine_app/views/splash.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../../controllers/login_service.dart';

// ignore: must_be_immutable
class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({Key? key}) : super(key: key);
  LoginService loginService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: background,
            foregroundColor: black,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text("계정 설정"),
          ),
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
              // kangmin(context, ProfileSettingsPage());
              Get.to(ProfileSettingsPage());
            },
            shape: Border(
              bottom: BorderSide(width: 0.8.w, color: grey500),
            ),
          ),
// <<<<<<< HEAD
          //   onTap: () {
          //     kangmin(context, ProfileSettingsPage());
          //   },
          //   shape: Border(
          //     bottom: BorderSide(width: 0.8.w, color: grey500),
          //   ),
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.logout,
          //     size: 28.r,
          //     color: black,
          //   ),
          //   title: Text(
          //     '로그아웃',
          //     style: AppleFont22_Black,
          //   ),
          //   onTap: (() {
          //     showDialog(
          //         context: context,
          //         builder: ((context) {
          //           return signOutAlertDialog(() async {
          //             Get.back();
          //           }, () {
          
          //             loginService.signOut();
          //             // ReportController _reportController = Get.find();
          //             // _reportController.onClose(() {
          //             //   print();
          //             // });
          //             // CalendarController _calendarController = Get.find();
          //             // _calendarController.dispose();
// =======
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
                      loginService.signOut().then((value) {
                        Get.offAll(() => SplashScreen());
                      });
// >>>>>>> 3d750ca0523deb2ee882362817014287392bdc86
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
                    }, () async{
                      await loginService.dataDelete();
                      Get.offAll(() => SplashScreen());
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
                      loginService.dataDelete();
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
      ),
    );
  }
}

void onPressed() {
  //
}
