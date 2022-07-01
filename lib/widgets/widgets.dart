//define global widgets here such as appbar
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../utils/constants.dart';
import '../utils/colors.dart';

Widget NextButtonBig(VoidCallback? onPressed) {
  return Container(
    width: 335.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: FontGray14_50,
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
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
        SizedBox(
          width: 24.w,
        ),
        NextButtonSmall(onPressedNext),
      ],
    ),
  );
}

Widget BackButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 107.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '이전',
        style: FontGray14_700,
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 212, 212, 212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget NextButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 204.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: FontGray14_50,
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget SaveButtonGray(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '저장',
        style: FontGray14_50,
      ),
      style: ElevatedButton.styleFrom(
        primary: gray500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget SaveButtonBlue(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '저장',
        style: FontGray14_50,
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget MakeMyRoutineButton(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '나만의 쾌변 루틴 만들기',
        style: FontGray14_50,
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget AddButton(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          SizedBox(
            width: 6.w,
          ),
          Text(
            '추가하기',
            style: FontGray14_50,
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget AddRoutineButton(VoidCallback? onPressed) {
  return Container(
    width: 348.w,
    height: 56.h,
    child: OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: gray50,
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(
            '나만의 루틴 항목 만들기',
            style: FontGray14_600,
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        primary: gray600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget PlusSquareButton(VoidCallback? onPressed) {
  return Container(
    width: 56.w,
    height: 56.h,
    decoration: BoxDecoration(
      color: blue100,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: IconButton(
      iconSize: 24.r,
      icon: Icon(Icons.add),
      onPressed: onPressed,
      color: primary,
    ),
  );
}

Widget DeleteAlertDialog(
    VoidCallback? onPressedCancel, VoidCallback? onPressedDelete) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(20.r),
    )),
    insetPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: Container(
      child: Column(children: [
        Container(
          width: 312.w,
          height: 120.h,
          child: Center(
              child: Text(
            '정말로 배변 기록을 \n삭제 하시겠습니까?',
            style: FontGray16_900,
            textAlign: TextAlign.center,
          )),
        ),
        Row(
          children: [
            InkWell(
              onTap: onPressedCancel,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                  ),
                  color: gray500,
                ),
                width: 124.w,
                height: 56.h,
                child: Center(
                    child: Text(
                  '취소',
                  style: FontGray16_900,
                )),
              ),
            ),
            InkWell(
              onTap: onPressedDelete,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                  ),
                  color: primary,
                ),
                width: 188.w,
                height: 56.h,
                child: Center(
                  child: Text(
                    '삭제',
                    style: FontGray16_50,
                  ),
                ),
              ),
            )
          ],
        )
      ]),
    ),
  );
}

Widget SaveAlertDialog(VoidCallback? onPressed) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(20.r),
    )),
    insetPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: Container(
      child: Column(children: [
        Container(
          width: 312.w,
          height: 120.h,
          child: Center(
              child: Text(
            '루틴 설정이 \n저장 되었습니다.',
            style: FontGray16_900,
            textAlign: TextAlign.center,
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
                '확인',
                style: FontGray16_50,
              ),
            ),
          ),
        )
      ]),
    ),
  );
}

