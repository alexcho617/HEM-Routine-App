import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../controllers/login_service.dart';

class ProfileSettingsPage extends StatefulWidget {
  ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  LoginService loginService = Get.find();
  final nameController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  bool isMale = true;
  bool enableBtn = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: background,
        child: Column(
          children: [
            customAppBar(context, '프로필 설정'),
            Padding(
              padding: EdgeInsets.all(22.r),
              child: Form(
                key: _formKey,
                onChanged: (() {
                  setState(() {
                    enableBtn = _formKey.currentState!.validate();
                  });
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('사용자 이름'),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: '사용자 이름 입력(최대 10자)',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.replay_circle_filled_rounded),
                            onPressed: () {
                              //controller.stashname();
                            },
                          )),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '사용자 이름을 입력하세요';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text('성별'),
                    ),
                    genderchooseButton(() {
                      //when pressed Male
                      setState(() {
                        isMale = true;
                      });
                    }, () {
                      //when pressed Female
                      setState(() {
                        isMale = false;
                      });
                    }),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text('생년월일'),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 139.h,
                      child: buildDatePicker(),
                    ),
                    SizedBox(
                      height: 66.h,
                    ),
                    saveButtonLong(
                        saveButtonPressed, enableBtn ? primary : grey600),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => CupertinoDatePicker(
        initialDateTime: selectedDateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime value) {
          setState(() {
            selectedDateTime = value;
          });
        },
      );

  void saveButtonPressed() {
    if (enableBtn) {
      loginService.profileSetting(
          nameController.text, selectedDateTime, isMale ? "Male" : "Female");
      ScaffoldMessenger.of(context.findAncestorStateOfType<HomePageState>()!.context)
          .showSnackBar(SnackBar(content: Text("저장되었습니다")));
      Navigator.pop(context);
    }
  }

  Widget genderchooseButton(
    VoidCallback? onPressedMale,
    VoidCallback? onPressedFemale,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 163.w,
          height: 48.h,
          child: ElevatedButton(
            onPressed: onPressedMale,
            child: Text(
              '남자',
              style: AppleFont14_White,
            ),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: isMale ? primary : grey600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        Container(
          width: 163.w,
          height: 48.h,
          child: ElevatedButton(
            onPressed: onPressedFemale,
            child: Text(
              '여자',
              style: AppleFont14_White,
            ),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: isMale ? grey600 : primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void onPressed() {
  //
}

Widget saveButtonLong(VoidCallback? onPressed, Color color) {
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
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}
