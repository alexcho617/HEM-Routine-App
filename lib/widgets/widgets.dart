//define global widgets here such as appbar
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/models/routine.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';
import 'package:hem_routine_app/views/setting/account_settings.dart';
import '../utils/constants.dart';
import '../utils/colors.dart';
import '../controller/routineItemController.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../views/routine/routine.dart';

Widget nextButtonBig(VoidCallback? onPressed) {
  return Container(
    width: 335.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget disabledNextButtonBig(VoidCallback? onPressed) {
  return Container(
    width: 335.w,
    height: 48.h,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 212, 212, 212),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Center(
      child: Text(
        '다음',
        style: AppleFont14_Grey700,
      ),
    ),
  );
}

Widget nextAndBackButton(
    VoidCallback? onPressedBack, VoidCallback onPressedNext) {
  return Container(
    width: 335.w,
    height: 48.h,
    child: Row(
      children: [
        backButtonSmall(onPressedBack),
        SizedBox(
          width: 24.w,
        ),
        nextButtonSmall(onPressedNext),
      ],
    ),
  );
}

Widget backButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 107.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '이전',
        style: AppleFont14_Grey700,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: Color.fromARGB(255, 212, 212, 212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget nextButtonSmall(VoidCallback? onPressed) {
  return Container(
    width: 204.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget saveButtonGray(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '저장',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: grey500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget saveButtonBlue(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '저장',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}

Widget makeMyRoutineButton(VoidCallback? onPressed) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '나만의 쾌변 루틴 만들기',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget addButton(VoidCallback? onPressed) {
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
            style: AppleFont14_White,
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget addRoutineButton(VoidCallback? onPressed) {
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
            color: grey50,
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(
            '나만의 루틴 항목 만들기',
            style: AppleFont14_Grey600,
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        primary: grey600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget plusSquareButton(VoidCallback? onPressed) {
  return Container(
    width: 56.w,
    height: 56.h,
    decoration: BoxDecoration(
      color: blue100,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: grey500,
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(1, 1),
        )
      ],
    ),
    child: IconButton(
      iconSize: 24.r,
      icon: Icon(Icons.add),
      onPressed: onPressed,
      color: primary,
    ),
  );
}

Widget deleteAlertDialog(
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
            style: AppleFont16_Black,
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
                  color: grey500,
                ),
                width: 124.w,
                height: 56.h,
                child: Center(
                    child: Text(
                  '취소',
                  style: AppleFont16_Black,
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
                    style: AppleFont16_White,
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

Widget saveAlertDialog(VoidCallback? onPressed) {
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
            style: AppleFont16_Black,
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
                style: AppleFont16_White,
              ),
            ),
          ),
        )
      ]),
    ),
  );
}

Widget routineItemList(RoutineItemController controller) {
  int itemLength = controller.list.length;
  return ReorderableListView.builder(
    padding: EdgeInsets.all(10.r),
    itemBuilder: (BuildContext context, int index) {
      double percent = controller.getPercent(
          controller.countList[index], controller.list[index].goalCount);
      return Padding(
        key: Key('$index'),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: PhysicalModel(
          color: white,
          elevation: 5.r,
          borderRadius: BorderRadius.circular(12.r),
          child: ListTile(
            shape: RoundedRectangleBorder(
              // side: BorderSide(
              //   color: Colors.black,
              //   width: 1.r,
              // ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              child: Icon(Icons.menu),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            horizontalTitleGap: 0,
            minVerticalPadding: 22.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.list[index].name,
                  style: AppleFont18_Black,
                ),
                Column(
                  children: [
                    Text(
                      '수행/목표',
                      style: AppleFont14_Grey600,
                    ),
                    Text(
                      '${controller.countList[index]}/${controller.list[index].goalCount}',
                      style: AppleFont14_Grey600,
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 46.w,
                  height: 46.h,
                  child: circluarGuage(percent),
                ),
                Container(
                  width: 34.w,
                  height: 34.h,
                  child: InkWell(
                    onTap: () => controller.onPressed(),
                    child: Ink(
                      child: CircleAvatar(
                        backgroundColor: blue600,
                        child: Icon(
                          Icons.add,
                          color: grey50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    itemCount: itemLength,
    onReorder: (int oldIndex, int newIndex) {
      controller.itemReorder(oldIndex, newIndex);
    },
  );
}

Widget circluarGuage(double percent) {
  return Container(
    child: SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          minimum: 0,
          maximum: 1,
          axisLineStyle: AxisLineStyle(
            color: white,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: percent,
              color: yellow,
              startWidth: 3.r,
              endWidth: 3.r,
            ),
          ],
        )
      ],
    ),
  );
}

Widget halfCircluarGuage(double percent) {
  return Container(
    width: 225.w,
    height: 225.h,
    child: Stack(
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 180,
              endAngle: 0,
              minimum: 0,
              maximum: 1,
              axisLineStyle: AxisLineStyle(color: grey400, thickness: 21.r),
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: percent,
                  color: primary,
                  startWidth: 21.r,
                  endWidth: 21.r,
                ),
              ],
            )
          ],
        ),
        Positioned(
          bottom: 112.h,
          left: 74.5.w,
          child: Column(
            children: [
              Text(
                "달성도",
                style: AppleFont14_Grey600,
              ),
              Text(
                (percent * 100).toInt().toString() + "%",
                style: AppleFont36_Blue600,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget achieveAlertDialog(String name, VoidCallback? onPressed) {
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
          height: 302.h,
          child: Column(
            children: [
              SizedBox(
                // TODO: Change This SizedBox Widget to Icon
                height: 178.w,
              ),
              Container(
                  height: 40.h,
                  child: Text(
                    '오늘의 루틴 목표 달성!',
                    style: AppleFont22_Black,
                  )),
              Container(
                height: 48.h,
                child: Text(
                  '$name 님이 설정하신\n루틴 일일 목표를 100% 달성했어요!',
                  style: AppleFont16_Black,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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
                style: AppleFont16_White,
              ),
            ),
          ),
        )
      ]),
    ),
  );
}

Widget routineStartAlertDialog(
    VoidCallback? onPressedCancel, VoidCallback? onPressedStart) {
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
          height: 302.h,
          child: Column(
            children: [
              SizedBox(
                // TODO: Change This SizedBox Widget to Icon
                height: 178.w,
              ),
              Container(
                  height: 40.h,
                  child: Text(
                    '루틴을 도전하세요!',
                    style: AppleFont22_Black,
                  )),
              Container(
                height: 48.h,
                child: Text(
                  '설정하신 루틴을\n오늘부터 도전해 보세요!',
                  style: AppleFont16_Black,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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
                  color: grey500,
                ),
                width: 124.w,
                height: 56.h,
                child: Center(
                    child: Text(
                  '취소',
                  style: AppleFont16_Black,
                )),
              ),
            ),
            InkWell(
              onTap: onPressedStart,
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
                    '루틴 시작',
                    style: AppleFont16_White,
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

Widget SelectedRoutineButton(VoidCallback? onPressed, String type) {
  return Container(
    height: 40.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        ' ${type} ',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // minimumSize: Size.zero, // Set this
        // padding: EdgeInsets.zero,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
    ),
  );
}

Widget UnSelectedRoutineButton(VoidCallback? onPressed, String type) {
  return Container(
    height: 40.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        ' ${type} ',
        style: AppleFont14_Grey600,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // minimumSize: Size.zero, // Set this
        // padding: EdgeInsets.zero,
        primary: grey400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
    ),
  );
}

Widget CustomBottomSheet(BuildContext context, Widget contents) {
  return Container(
    height: 674.h,
    child: Scaffold(body: contents),
  );
}

Widget routineCard(
    String name, int day, double percent, int rank, VoidCallback? onPressed) {
  return Card(
    elevation: 5,
    shadowColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    color: Colors.transparent,
    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
          color: white,
        ),
        width: 144.w,
        height: 151.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.r, 16.r, 0, 0),
              child: SizedBox(
                  height: 24.h,
                  child: Text(
                    name,
                    style: AppleFont16_Black,
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.r, 0, 0, 16.r),
              child: SizedBox(
                height: 16.h,
                child: Text(
                  '$day 일간',
                  style: AppleFont12_Grey500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                circleGauzeIndicator(percent),
                starRankIndicator(rank),
              ],
            )
          ],
        ),
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
          width: 144.w,
          height: 40.h,
          child: Center(
            child: Text(
              '자세히 보기 >',
              style: AppleFont11_White,
            ),
          ),
        ),
      )
    ]),
  );
}

Widget circleGauzeIndicator(double percent) {
  return Column(
    children: [
      Container(
        width: 43.w,
        height: 43.h,
        child: Center(
          child: Text(
            percent.toInt().toString() + "%",
            style: AppleFont12_Blue600,
          ),
        ),
        decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: CircleBorder(side: BorderSide(width: 0.5, color: blue600))),
      ),
      Padding(
        padding: EdgeInsets.all(3.r),
        child: Text(
          '달성도',
          style: AppleFont12_Black,
        ),
      ),
    ],
  );
}

Widget starRankIndicator(int rank) {
  return Container(
    child: Text(
      "여긴 \n이미지로\n 해야할듯",
      style: AppleFont12_Black,
    ),
  );
}


Widget dataAlertDialog(
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
    content: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 176.h),
      child: Column(children: [
        Container(
          width: 312.w,
          height: 120.h,
          child: Center(
              child: Text(
            '데이터를 초기화하면\n데이터를 복구할 수 없습니다.',
            style: AppleFont16_Black,
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
                  color: grey500,
                ),
                width: 124.w,
                height: 56.h,
                child: Center(
                    child: Text(
                  '취소',
                  style: AppleFont16_Black,
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
                    '데이터 초기화',
                    style: AppleFont16_White,
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

Widget withDrawalAlertDialog(
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
    content: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 176.h),
      child: Column(children: [
        Container(
          width: 312.w,
          height: 120.h,
          child: Center(
              child: Text(
            '회원 탈퇴를 하시면\n이전 데이터가 초기화 됩니다.\n정말로 회원탈퇴를 하시겠습니까?',
            style: AppleFont16_Black,
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
                  color: grey500,
                ),
                width: 124.w,
                height: 56.h,
                child: Center(
                    child: Text(
                  '취소',
                  style: AppleFont16_Black,
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
                    '회원탈퇴',
                    style: AppleFont16_White,
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

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;
  const CustomNavigator({Key? key, required this.page, required this.navigatorKey}) : super(key: key);


  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}


class _CustomNavigatorState extends State<CustomNavigator> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}


Widget addRoutineItemList(RoutineItemController controller) {
  int itemLength = controller.list.length;
  return ReorderableListView.builder(
    padding: EdgeInsets.all(10.r),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        key: Key('$index'),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: PhysicalModel(
          color: white,
          elevation: 5.r,
          borderRadius: BorderRadius.circular(12.r),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              child: Icon(Icons.menu),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            horizontalTitleGap: 0,
            minVerticalPadding: 22.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    controller.list[index].name,
                    style: AppleFont18_Black,
                  ),
                ),
                Text('일일 목표 ${controller.list[index].goalCount}회'),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onPressed,
            )
          ),
        ),
      );
    },
    itemCount: itemLength,
    onReorder: (int oldIndex, int newIndex) {
      controller.itemReorder(oldIndex, newIndex);
    },
  );
}

Widget customAppBar(context){
  return AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('루틴 항목 설정'),
        );
}
