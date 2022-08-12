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
        Text('이번 달 배변 횟수 : ${_reportController.thisMonthEventCount.value}'),
      ],
    );
  }
}