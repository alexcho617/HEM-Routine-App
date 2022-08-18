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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 212.h,
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
                    color: blue100, borderRadius: BorderRadius.circular(10.r)),
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
                          Text(
                            '${_reportController.sevenDayEventCount.value}회',
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
                thickness: 3,
              ),
            ],
          ),
        ),
        Container(
          height: 442.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                circularAnalysisChart(_reportController.pieChartData),
                // Text('묽은변 횟수 : ${_reportController.pieChartData[0]}'),
                // Text('쾌변 횟수 : ${_reportController.pieChartData[1]}'),
                // Text('단단한 변 횟수 : ${_reportController.pieChartData[2]}'),
                Divider(
                  thickness: 3,
                ),
                GetBuilder<ReportController>(builder: (context) {
                  return monthlyRateChart(_reportController.lineChartData);
                }),
                // Text('월별 쾌변율 : ${_reportController.lineChartData}'),
                Divider(
                  thickness: 3,
                ),
                GetBuilder<ReportController>(builder: (context) {
                  return circularColorChart(_reportController.colorChartData7);
                }),
                Text('1주일(7일) 색상통계 : ${_reportController.colorChartData7}'),
                Text('1개월(30일) 색상통계 : ${_reportController.colorChartData30}'),
                Text('3개월(90일) 색상통계 : ${_reportController.colorChartData90}'),
                Divider(
                  thickness: 3,
                ),
                Text('배변 패턴'),
                BarGraph()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
