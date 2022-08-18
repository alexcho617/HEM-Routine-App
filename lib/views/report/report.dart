import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/report_controller.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/views/report/bar_graph.dart';

import './report_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportController _reportController = Get.put(ReportController());
  final LoginService _loginService = Get.find();

  //default colorchart is set to 3months
  List<bool> colorChartButtonValue = [true, false, false];
  int colorChartDay = 90;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Column(
        children: [
          Container(
            height: 192.h,
            child: Column(
              children: [
                Text(
                  'Report',
                  style: ReportTitleFont,
                ),
                Text(
                  '${_loginService.name}의 리포트',
                  style: AppleFont24_Black,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  height: 102.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      color: blue100,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '주간 배변 횟수',
                              style: AppleFont14_Black,
                            ),
                            Text(
                              '${_reportController.sevenDayEventCount.value}회',
                              style: AppleFont22_Blue600,
                            ),
                            if (int.parse(_reportController
                                    .sevenDayEventCount.value) <
                                3)
                              Text(
                                '적은 편',
                                style: AppleFont12_Blue600,
                              )
                            else if (int.parse(_reportController
                                    .sevenDayEventCount.value) >
                                20)
                              Text(
                                '많은 편',
                                style: AppleFont12_Blue600,
                              )
                            else
                              Text(
                                '적당한 편',
                                style: AppleFont12_Blue600,
                              ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '수행 완료 루틴',
                              style: AppleFont14_Black,
                            ),
                            Text('${_reportController.getCompletedRoutines()}회',
                                style: AppleFont22_Blue600),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '평균 루틴 달성도',
                              style: AppleFont14_Black,
                            ),
                            Text(
                                (_reportController.getAvgRoutineCompletion() *
                                            100)
                                        .toStringAsFixed(0) +
                                    "%",
                                style: AppleFont22_Blue600),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
          Container(
            height: 530.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '쾌변율 분석',
                        style: AppleFont16_BlackBold,
                      ),
                    ],
                  ),
                  circularAnalysisChart(_reportController.pieChartData),
                  // Text('묽은변 횟수 : ${_reportController.pieChartData[0]}'),
                  // Text('쾌변 횟수 : ${_reportController.pieChartData[1]}'),
                  // Text('단단한 변 횟수 : ${_reportController.pieChartData[2]}'),

                  GetBuilder<ReportController>(builder: (context) {
                    return monthlyRateChart(_reportController.lineChartData);
                  }),
                  // Text('월별 쾌변율 : ${_reportController.lineChartData}'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.w),
                        child: Text(
                          '색상 통계',
                          style: AppleFont16_BlackBold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 300.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //3month button
                        ElevatedButton(
                          onPressed: () {
                            if (colorChartButtonValue[0] == false) {
                              setState(() {
                                colorChartDay = 90;
                                colorChartButtonValue[0] = true;
                                colorChartButtonValue[1] = false;
                                colorChartButtonValue[2] = false;
                              });
                            }
                          },
                          child: Text(
                            '최근 3개월',
                            style: colorChartButtonValue[0]
                                ? AppleFont14_White
                                : AppleFont14_Black,
                          ),
                          style: colorChartButtonValue[0]
                              ? reportColorChartBlueButtonStyle
                              : reportColorChartGreyButtonStyle,
                        ),
                        // 1month button
                        ElevatedButton(
                          onPressed: () {
                            if (colorChartButtonValue[1] == false) {
                              setState(() {
                                colorChartDay = 30;
                                colorChartButtonValue[0] = false;
                                colorChartButtonValue[1] = true;
                                colorChartButtonValue[2] = false;
                              });
                            }
                          },
                          child: Text(
                            '최근 1개월',
                            style: colorChartButtonValue[1]
                                ? AppleFont14_White
                                : AppleFont14_Black,
                          ),
                          style: colorChartButtonValue[1]
                              ? reportColorChartBlueButtonStyle
                              : reportColorChartGreyButtonStyle,
                        ),
                        //1week button
                        ElevatedButton(
                          onPressed: () {
                            if (colorChartButtonValue[2] == false) {
                              setState(() {
                                colorChartDay = 7;
                                colorChartButtonValue[0] = false;
                                colorChartButtonValue[1] = false;
                                colorChartButtonValue[2] = true;
                              });
                            }
                          },
                          child: Text(
                            '최근 1주일',
                            style: colorChartButtonValue[2]
                                ? AppleFont14_White
                                : AppleFont14_Black,
                          ),
                          style: colorChartButtonValue[2]
                              ? reportColorChartBlueButtonStyle
                              : reportColorChartGreyButtonStyle,
                        ),
                      ],
                    ),
                  ),

                  GetBuilder<ReportController>(builder: (context) {
                    switch (colorChartDay) {
                      case 90:
                        return circularColorChart(
                            _reportController.colorChartData90);
                      case 30:
                        return circularColorChart(
                            _reportController.colorChartData30);
                      case 7:
                        return circularColorChart(
                            _reportController.colorChartData7);
                      default:
                        return circularColorChart(
                            _reportController.colorChartData90);
                    }
                  }),
                  // Text('1주일(7일) 색상통계 : ${_reportController.colorChartData7}'),
                  // Text('1개월(30일) 색상통계 : ${_reportController.colorChartData30}'),
                  // Text('3개월(90일) 색상통계 : ${_reportController.colorChartData90}'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.w),
                        child: Text('배변 패턴', style: AppleFont16_BlackBold),
                      ),
                    ],
                  ),
                  BarGraph(),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
