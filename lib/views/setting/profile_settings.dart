import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../controllers/login_service.dart';

class ProfileSettingsPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: background,
          child: Column(
            children: [
              // customAppBar(context, '프로필 설정'),
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
                title: const Text('프로필 설정'),
              ),
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
                      const Text('사용자 이름'),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: '사용자 이름 입력(최대 10자)',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                  Icons.replay_circle_filled_rounded),
                              onPressed: () {
                                //controller.stashname();
                                nameController.clear();
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
                        child: const Text('성별'),
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
                      const Text('생년월일'),
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
      // ScaffoldMessenger.of(
      //         context.findAncestorStateOfType<HomePageState>()!.context)
      //     .showSnackBar(const SnackBar(content: Text("저장되었습니다")));
      Get.snackbar('수정 완료','저장되었습니다.');
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
        SizedBox(
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
        SizedBox(
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
  return SizedBox(
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
