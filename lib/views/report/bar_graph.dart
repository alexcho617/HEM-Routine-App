import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/report_controller.dart';
import '../../utils/calendarUtil.dart';
import '../../utils/constants.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({Key? key}) : super(key: key);

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  double blockHeight = 300.h;
  double blockWidth = 45.w;

  double totalHeight = 350.h;
  double totalWidth = 350.w;

  double markerHeight = 30.h;
  final ReportController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YAxis(
                  gap: SizedBox(
                    height: blockHeight / 5 - 10.h,
                  ),
                ),
                Stack(children: [
                  Positioned(
                    child: SizedBox(
                      width: 321,
                      height: blockHeight,
                      child: Canvas(
                        gap: SizedBox(
                          height: blockHeight / 5 - 10.h,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: barWidget(),
                  )
                ]
                    //single day unit, need size adjustment.
                    )
              ],
            ),
          ],
        ),
      );
    });
  }

  List<Widget> barWidget() {
    List<Widget> bars = [];
    //하루

    for (var key in keysForBarChart) {
      if (_controller.weekEvents[key] != null) {
        var events = _controller.weekEvents[key];
        bars.add(Column(
          children: [
            SizedBox(
              //delete border
              // decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.black),
              //     color: blue50),
              width: blockWidth,
              height: blockHeight,
              child: Stack(
                children: <Widget>[
                  //하루의 이벤트 들
                  for (var event in events)
                    Positioned(
                      left: 8.w,
                      top: getMarkerPosition(event.time),
                      // width: blockWidth,
                      height: markerHeight,
                      child: Image(
                        width: 32.w,
                        height: 25.h,
                        image:
                            AssetImage('assets/marker/${event.iconCode}.png'),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              parseDate(key),
              style: AppleFont12_Black,
            ),
          ],
        ));
      } else {
        bars.add(
          Column(
            children: [
              SizedBox(
                // decoration: BoxDecoration(
                //     border: Border.all(width: 1, color: Colors.black),
                //     color: blue50),
                width: blockWidth,
                height: blockHeight,
                // color: blue100,
              ),
              Text(
                parseDate(key),
                style: AppleFont12_Black,
              ),
            ],
          ),
        );
      }
    }
    return bars;
  }

  double getMarkerPosition(DateTime eventTime) {
    double spacingOffset = 190.h;
    double positionOffset = 4.h;

    num position = (eventTime.hour * 60 + eventTime.minute) *
            blockHeight /
            (1440 + spacingOffset) +
        positionOffset;
    
    return position.toDouble(); // assets 크기 절반?
  }

  double getTimelinePosition(DateTime eventTime) {
    double spacingOffset = 190.h;
    double positionOffset = 4.h;
    
    num position = (eventTime.hour * 60 + eventTime.minute) *
            blockHeight /
            (1440 + spacingOffset) +
        positionOffset;
    
    return position.toDouble(); // assets 크기 절반?
  }
}

class YAxis extends StatelessWidget {
  const YAxis({
    Key? key,
    required this.gap,
  }) : super(key: key);

  final SizedBox gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            Text(
              '00시',
              style: AppleFont12_Black,
            ),
          ],
        ),
        gap,
        Text(
          '06시',
          style: AppleFont12_Black,
        ),
        gap,
        Text(
          '12시',
          style: AppleFont12_Black,
        ),
        gap,
        Text(
          '18시',
          style: AppleFont12_Black,
        ),
        gap,
        Text(
          '24시',
          style: AppleFont12_Black,
        ),
      ],
    );
  }
}

class Canvas extends StatelessWidget {
  const Canvas({
    Key? key,
    required this.gap,
  }) : super(key: key);

  final SizedBox gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 12.h,
        ),
        const Divider(
          thickness: 1,
        ),
        gap,
        const Divider(
          thickness: 1,
        ),
        gap,
        const Divider(
          thickness: 1,
        ),
        gap,
        const Divider(
          thickness: 1,
        ),
        gap,
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
