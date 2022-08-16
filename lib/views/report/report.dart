import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/report_controller.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportController _reportController = Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Report'),
        Text('사용자의 리포트'),
        Row(
          children: [
            Column(
              children: [
                Text('주간(최근 7일) 배변 횟수:'),
                Text(_reportController.sevenDayEventCount.value),
              ],
            )
          ],
        ),
        Text('묽은변 횟수 : ${_reportController.pieChartData[0]}'),
        Text('쾌변 횟수 : ${_reportController.pieChartData[1]}'),
        Text('단단한 변 횟수 : ${_reportController.pieChartData[2]}'),
        Divider(
          thickness: 3,
        ),
        Text('월별 쾌변율 : ${_reportController.lineChartData}'),
        Divider(
          thickness: 3,
        ),
        Text('1주일(7일) 색상통계 : ${_reportController.colorChartData7}'),
        Text('1개월(30일) 색상통계 : ${_reportController.colorChartData30}'),
        Text('3개월(90일) 색상통계 : ${_reportController.colorChartData90}'),
      ],
    );
  }
}
