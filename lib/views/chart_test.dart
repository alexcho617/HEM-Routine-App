import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../utils/colors.dart';

class ChartTestPage extends StatefulWidget {
  const ChartTestPage({Key? key}) : super(key: key);

  @override
  State<ChartTestPage> createState() => _ChartTestPageState();
}

class _ChartTestPageState extends State<ChartTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Chart Test Page"),
            Container(
              color: Colors.pink[50],
              child: circularChart(0.2, 0.7, 0.1),
            ),
          ],
        ),
      ),
    );
  }
}

Widget circularChart(double x1, double x2, double x3) {
  List<ChartData> chartdatas = [
    ChartData("묽은변", x1, color: Colors.amber),
    ChartData("쾌변", x2, color: Colors.deepPurple),
    ChartData("단단한 변", x3, color: Colors.red),
  ];
  return SfCircularChart(
    annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
        // angle: 0,
        // radius: '0%',
        widget: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Text("이번달 쾌변율", style: AppleFont14_Grey600,),
            Text("${(x2 * 100).toStringAsFixed(0)}%",style: AppleFont36_Blue600,)
          ],
        ),
      ),
    ],
    legend: Legend(isVisible: true, position: LegendPosition.bottom),
    series: <CircularSeries>[
      DoughnutSeries(
          dataSource: chartdatas,
          pointColorMapper: (data, index) {
            return data.color;
          },
          xValueMapper: (data, index) {
            return data.x;
          },
          yValueMapper: (data, index) {
            return data.y;
          },
          innerRadius: '75%',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return Text((data.y * 100).toStringAsFixed(0) + "%", style: TextStyle(color: white, fontSize: 14),);
            },
          ),
          ),
    ],
  );
}

class ChartData {
  ChartData(this.x, this.y, {this.color = Colors.pinkAccent});
  final String x;
  final double y;
  final Color color;
}
