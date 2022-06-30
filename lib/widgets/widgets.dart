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

Widget NextAndBackButton(
    VoidCallback? onPressedBack, VoidCallback onPressedNext) {
  return Container(
    width: 335.w,
    height: 48.h,
    child: Row(
      children: [
        BackButtonSmall(onPressedBack),
        NextButtonSmall(onPressedNext),
      ],
    ),
  );
}

Widget BackButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 107.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '이전',
        style: FontButtonGray14,
      ),
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 212, 212, 212)),
    ),
  );
}

Widget NextButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 204.w,
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



TextStyle FontButtonWhite14 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    letterSpacing: 0.1);

TextStyle FontButtonGray14 = TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    letterSpacing: 0.1,
    color: Color.fromARGB(255, 117, 118, 127));
