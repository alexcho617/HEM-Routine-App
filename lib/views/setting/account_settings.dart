import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('계정 설정'),
      ),
      body: ListView(
        children: [
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
              Get.toNamed('/profileSettings');
            },
            shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
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
            onTap: onPressed,
            shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
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
                    }, onPressed);
                  }));
            },
            shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
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
            shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return withDrawalAlertDialog(() {
                      Get.back();
                    }, onPressed);
                  }));
            },
          ),
        ],
      ),
    );
  }
}

void onPressed() {
  //
}
