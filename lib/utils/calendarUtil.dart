// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/tableCalendar/table_calendar.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:intl/intl.dart';

import '../models/calendarEvent.dart';

LoginService loginService = Get.find();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

CalendarStyle kCalendarStyle = CalendarStyle(
  isTodayHighlighted: true,
  markerSizeScale: 1.0,
  markersAlignment: Alignment.center,
  markerDecoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/characterIconYellow.png'),
    ),
    shape: BoxShape.rectangle,
    // color: Colors.blue,
  ),
  selectedDecoration: BoxDecoration(
    color: Colors.blue,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  selectedTextStyle: TextStyle(color: Colors.white),
  todayDecoration: BoxDecoration(
    color: Colors.purpleAccent,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  defaultDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
  weekendDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
  ),
);

HeaderStyle kHeaderStyle = HeaderStyle(
  formatButtonVisible: false,
  titleCentered: true,
  formatButtonShowsNext: false,
  formatButtonDecoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(5.0),
  ),
  formatButtonTextStyle: TextStyle(
    color: Colors.white,
  ),
);

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

DateTime parseDay(DateTime before) {
  DateTime after = DateTime(before.year, before.month, before.day);
  return after;
}

String parseDayToString(DateTime before) {
  String weekday;
  switch (before.weekday) {
    case 1:
      weekday = '월';
      break;
    case 2:
      weekday = '화';
      break;
    case 3:
      weekday = '수';
      break;
    case 4:
      weekday = '목';
      break;
    case 5:
      weekday = '금';
      break;
    case 6:
      weekday = '토';
      break;
    case 7:
      weekday = '일';
      break;

    default:
      weekday = '월';
  }
  return "${before.year}-${before.month}-${before.day} ($weekday)";
}

String parseColorCode(String code) {
  String color = '';
  switch (code) {
    case '0':
      color = '회색';
      break;
    case '1':
      color = '붉은색';
      break;
    case '2':
      color = '초록색';
      break;
    case '3':
      color = '노란색';
      break;
    case '4':
      color = '갈색';
      break;
    case '5':
      color = '고동색';
      break;
    case '6':
      color = '흑색';
      break;
    default:
      '';
  }
  return color;
}

String parseTypeCode(String code) {
  String type = '';
  switch (code) {
    case '0':
      type = '물변';
      break;
    case '1':
      type = '진흙변';
      break;
    case '2':
      type = '무른변';
      break;
    case '3':
      type = '매끈변';
      break;
    case '4':
      type = '금간변';
      break;
    case '5':
      type = '딱딱변';
      break;
    case '6':
      type = '토끼변';
      break;
    default:
      '매끈변';
  }
  return type;
}

String parseHardnessCode(String code) {
  String hardness = '';
  switch (code) {
    case '0':
      hardness = '많이 불편';
      break;
    case '1':
      hardness = '불편';
      break;
    case '2':
      hardness = '편함';
      break;
    case '3':
      hardness = '매우 편함';
      break;
    default:
      '';
  }
  return hardness;
}

String parseTime(DateTime date) {
  String dateString = '';

  dateString = DateFormat('a hh:mm', 'ko_KR').format(date);
  return dateString;
}

//TODO make function for calendar event feedback 기획 12페이지
//function made by yechan jung

Widget calendarAlertDialog(CalendarEvent event, VoidCallback? onPressed) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(20.r),
    )),
    insetPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: SizedBox(
      height: 470.h,
      child: Column(children: [
        SizedBox(
          width: 312.w,
          height: 414.h,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 52.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.0.w),
                child: Text(
                  parseCalendarMessage(event),
                  style: AppleFont16_Black,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
              // SizedBox(
              //   height: 21.h,
              // ),
              Container(
                padding: EdgeInsets.all(8.0.sp),
                alignment: Alignment.center,
                child: Image(
                  width: 120.w,
                  height: 79.h,
                  image: AssetImage("assets/marker/${event.iconCode}.png"),
                ),
              ),
              Text(
                parseTypeCode(event.type),
                style: AppleFont16_Black,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.0.w),
                child: Divider(
                  thickness: 2.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(21.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    event.color != '9'
                        ? Column(
                            children: [
                              Text(parseColorCode(event.color),
                                  style: AppleFont16_Black),
                              Container(
                                padding: EdgeInsets.all(8.0.sp),
                                alignment: Alignment.center,
                                child: Image(
                                  width: 60.w,
                                  height: 60.h,
                                  image: AssetImage(
                                      "assets/button/color/${event.color}.png"),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    event.hardness != '9'
                        ? Column(
                            children: [
                              Text(parseHardnessCode(event.hardness),
                                  style: AppleFont16_Black),
                              Container(
                                padding: EdgeInsets.all(8.0.sp),
                                alignment: Alignment.center,
                                child: Image(
                                  width: 60.w,
                                  height: 60.h,
                                  image: AssetImage(
                                      "assets/button/hardness/${event.hardness}.png"),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              )
            ],
          )),
        ),
        InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
              color: primary,
            ),
            width: 312.w,
            height: 56.h,
            child: Center(
              child: Text(
                '닫기',
                style: AppleFont16_White,
              ),
            ),
          ),
        )
      ]),
    ),
  );
}

String parseCalendarMessage(CalendarEvent event) {
  String user = loginService.name.value;
  if ((event.type == '0') && (event.hardness == '9')) {
    return "속이 많이 좋지 않으신 것 같아요. 😨";
  }
  if ((event.type == '1') && (event.hardness == '9')) {
    return "배가 아프시진 않으셨나요? 😫";
  }
  if ((event.type == '2' || event.type == '3' || event.type == '4') &&
      (event.hardness == '9')) {
    return "오늘도 성공하셨네요! 🤗";
  }
  if ((event.type == '5' || event.type == '6') && (event.hardness == '9')) {
    return "변을 보실 때 힘드시진 않으셨나요?🤔";
  }
  if ((event.type == '0') && (event.hardness == '0' || event.hardness == '1')) {
    return "배 아픈 것이 얼른 나았으면 좋겠어요. 😭";
  }
  if ((event.type == '1') && (event.hardness == '0' || event.hardness == '1')) {
    return "속이 많이 불편하셨죠? 😭";
  }
  if ((event.type == '2' || event.type == '3' || event.type == '4') &&
      (event.hardness == '0' || event.hardness == '1')) {
    return "쾌변 하실 수 있도록 응원해요!🥰";
  }
  if ((event.type == '5' || event.type == '6') &&
      (event.hardness == '0' || event.hardness == '1')) {
    return "변을 보실 때 힘드셨죠 😢";
  }
  if ((event.type == '0' || event.type == '1') &&
      (event.hardness == '2' || event.hardness == '3')) {
    return "배가 아프진 않으신 거죠?😊";
  }
  if ((event.type == '2' || event.type == '3' || event.type == '4') &&
      (event.hardness == '2' || event.hardness == '3')) {
    return "오늘도 완벽한 쾌변이네요!😍";
  }
  if ((event.type == '5' || event.type == '6') &&
      (event.hardness == '2' || event.hardness == '3')) {
    return "다음 번엔 꼭 쾌변할거에요!😉";
  }

  return "오늘도 성공하셨네요!";
}
