import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime currDateTime = DateTime.now();
  bool isMale = true;

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
          title: Text('프로필 설정'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: 348.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('사용자 이름'),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data E';
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
                  genderchooseButton(onPressed),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text('생년월일'),
                  SizedBox(
                    height: 139.h,
                    child: buildDatePicker(),
                  ),
                  saveButtonLong(saveButtonPressed, false ? primary : grey600),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildDatePicker() => CupertinoDatePicker(
        initialDateTime: currDateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime value) {
          //
        },
      );

  void saveButtonPressed() {
    if (_formKey.currentState!.validate()) {
      //do save
    }
  }

Widget genderchooseButton(VoidCallback? onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 163.w,
        height: 48.h,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            '남자',
            style: AppleFont14_White,
          ),
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: isMale? primary : grey600,
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
          onPressed: onPressed,
          child: Text(
            '여자',
            style: AppleFont14_White,
          ),
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: isMale? grey600 : primary,
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
