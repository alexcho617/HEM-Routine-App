import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
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
    return Container(
      color: white,
      child: Column(
        children: [
          customAppBar(context, '프로필 설정'),
          Padding(
            padding: EdgeInsets.all(22.r),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  customAppBar(context, '프로필 설정'),
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
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 139.h,
                    child: buildDatePicker(),
                  ),
                  SizedBox(
                    height: 66.h,
                  ),
                  saveButtonLong(saveButtonPressed, false ? primary : grey600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
            onPressed: onPressed,
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
