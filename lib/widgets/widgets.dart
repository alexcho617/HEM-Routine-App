//define global widgets here such as appbar
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget NextButtonBig(VoidCallback? onPressed) {
  return Container(
    width: 335.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: FontButtonWhite14,
      ),
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 51, 89, 183)),
    ),
  );
}

Widget BackButton(VoidCallback? onPressed) {
  return Container(
    width: 197.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '이전',
        style: FontButtonWhite14,
      ),
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 51, 89, 183)),
    ),
  );
}

TextStyle FontButtonWhite14 =
    TextStyle(fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w500 ,fontSize: 14.sp, letterSpacing: 0.1);
