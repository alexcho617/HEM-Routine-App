// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/models/routine_item.dart';
import 'colors.dart';

TextStyle BottomNavigationOptionStyle =
    TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold);

TextStyle ReportTitleFont = TextStyle(
  fontFamily: 'GmarketSansTTFMedium',
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  height: 1.25,
  color: grey700,
);

ButtonStyle reportColorChartGreyButtonStyle = ElevatedButton.styleFrom(
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  // minimumSize: Size.zero, // Set this
  // padding: EdgeInsets.zero,
  primary: grey400,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100.r),
  ),
);

ButtonStyle reportColorChartBlueButtonStyle = ElevatedButton.styleFrom(
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  // minimumSize: Size.zero, // Set this
  // padding: EdgeInsets.zero,
  primary: primary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100.r),
  ),
);

TextStyle AppleFont11_White = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 11.sp,
  letterSpacing: 0.5.sp,
  height: 1.25,
  color: grey50,
);

TextStyle AppleFont11_Grey700 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 11.sp,
  letterSpacing: 0.5.sp,
  height: 1.25,
  color: grey700,
);

TextStyle AppleFont11_Blue600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 11.sp,
  letterSpacing: 0.5.sp,
  height: 1.25,
  color: blue600,
);

TextStyle AppleFont12_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
  letterSpacing: 0.5.sp,
  height: 1.25,
  color: grey900,
);

TextStyle AppleFont12_Grey500 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
  letterSpacing: 0.4.sp,
  height: 1.25,
  color: grey500,
);

TextStyle AppleFont12_Blue600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
  letterSpacing: 0.4.sp,
  color: blue600,
);
TextStyle AppleFont14_Blue600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  letterSpacing: 0.4.sp,
  color: blue600,
);

TextStyle AppleFont14_White = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
  letterSpacing: 0.1.sp,
  color: grey50,
);

TextStyle AppleFont14_Grey700 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
  letterSpacing: 0.1.sp,
  color: grey700,
);

TextStyle AppleFont14_Grey600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  letterSpacing: 0.1.sp,
  color: grey600,
);

TextStyle AppleFont14_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
  letterSpacing: 0.1.sp,
  color: black,
);

TextStyle AppleFont16_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: grey900,
  height: 1.5,
);

TextStyle AppleFont16_Black01 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.1.sp,
  color: grey900,
  height: 1.5,
);

TextStyle AppleFont16_BlackBold = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: grey900,
  height: 1.5,
);

TextStyle AppleFont16_White = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: grey50,
);

TextStyle AppleFont16_Grey600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: grey600,
);

TextStyle AppleFont18_White = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: white,
);

TextStyle AppleFont18_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  letterSpacing: 0.5.sp,
  color: grey900,
);

TextStyle AppleFont22_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 22.sp,
  letterSpacing: 0.5.sp,
  color: grey900,
);

TextStyle AppleFont22_Blue600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 22.sp,
  letterSpacing: 0.5.sp,
  color: blue600,
);

TextStyle AppleFont24_Black = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w700,
  fontSize: 24.sp,
  letterSpacing: 0.5.sp,
  color: grey900,
);

TextStyle AppleFont36_Blue600 = TextStyle(
  fontFamily: 'AppleSDGothicNeoM',
  fontWeight: FontWeight.w400,
  fontSize: 36.sp,
  color: blue600,
);

enum CRUD { create, read, update, delete }

enum FromWhere { routineItemAdd, routineItemSetting }

class ScreenArguments {
  CRUD crud;
  FromWhere fromWhere;
  RoutineItem? routineItem;
  int index;

  ScreenArguments(this.crud, this.fromWhere, this.routineItem, this.index);
}
