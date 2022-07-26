import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/loginService.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

class RoutineBuildPage extends StatefulWidget {
  const RoutineBuildPage({Key? key}) : super(key: key);

  @override
  State<RoutineBuildPage> createState() => _RoutineBuildPageState();
}

class _RoutineBuildPageState extends State<RoutineBuildPage> {
  LoginService loginService = Get.find();
  final inputController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool isValid = true;
  bool activateButton = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          customAppBar(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  '루틴 이름',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: inputController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: isValid
                          ? Icon(Icons.cancel_outlined)
                          : Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                      onPressed: () {
                        inputController.clear();
                        _globalKey.currentState!.validate();
                      },
                    ),
                    hintText: '루틴 이름 입력(최대 20자)',
                  ),
                  onChanged: (text) {
                    // do something with text
                    _globalKey.currentState!.validate();
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        isValid = false;
                        activateButton = false;
                      });

                      return '내용을 입력해주세요';
                    } else if (value != null && value.length > 20) {
                      setState(() {
                        isValid = false;
                        activateButton = false;
                      });

                      return '20까지 입력 가능합니다.';
                    }
                    setState(() {
                      isValid = true;
                      activateButton = true;
                    });
                    return null;
                  },
                ),
                SizedBox(height: 48.h,),
                Text(
                  '루틴 수행 기간',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 139.h,
                  child: CupertinoPicker(
                    children: [
                      Text("1 일간"),
                      Text("2 일간"),
                      Text("3 일간"),
                      Text("4 일간"),
                      Text("5 일간"),
                      Text("6 일간"),
                      Text("7 일간"),
                      Text("8 일간"),
                      Text("9 일간"),
                      Text("10 일간"),
                      Text("11 일간"),
                      Text("12 일간"),
                      Text("13 일간"),
                      Text("14 일간"),
                      Text("15 일간"),
                    ],
                    onSelectedItemChanged: (value) {},
                    itemExtent: 25.h,
                  ),
                ),
                SizedBox(
                  height: 210.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    activateButton
                        ? nextButtonBig(() {
                          FirebaseFirestore.instance.collection('user/${loginService.auth.value.currentUser}/routine').add({
                            'averageComplete': 0,
                            'averageRating': 0,
                            'name': inputController.text
                          });
                        })
                        : disabledNextButtonBig(() {}),
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
