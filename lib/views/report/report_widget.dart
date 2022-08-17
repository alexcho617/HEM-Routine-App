import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

Widget circularAnalysisChart(List<double> x) {
  List<AnalysisChartData> chartdatas = [
    AnalysisChartData("묽은변", x[1], color: blue50),
    AnalysisChartData("쾌변", x[2], color: blue600),
    AnalysisChartData("단단한 변", x[3], color: blue200),
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
            Text(
              "이번 달 쾌변율",
              style: AppleFont14_Grey600,
            ),
            Text(
              "${(x[2] * 100).toStringAsFixed(0)}%",
              style: AppleFont36_Blue600,
            )
          ],
        ),
      ),
    ],
    legend: Legend(isVisible: true, position: LegendPosition.bottom),
    series: <CircularSeries>[
      DoughnutSeries(
        dataSource: chartdatas,
        startAngle: 270,
        endAngle: 270,
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
            return Text(
              (data.y * 100).toStringAsFixed(0) + "%",
              style: TextStyle(
                  color: pointIndex == 0 ? blue600 : white, fontSize: 14),
            );
          },
        ),
      ),
    ],
  );
}

class AnalysisChartData {
  AnalysisChartData(this.x, this.y, {this.color = Colors.pinkAccent});
  final String x;
  final double y;
  final Color color;
}

Widget circularColorChart(List<double> x) {
  List<ColorChartData> chartdatas = [
    ColorChartData(x[1], const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1)),
    ColorChartData(x[2], const Color.fromRGBO(0xDC, 0x6D, 0x69, 1)),
    ColorChartData(x[3], const Color.fromRGBO(0x88, 0xA8, 0x83, 1)),
    ColorChartData(x[4], const Color.fromRGBO(0xF6, 0xC1, 0x43, 1)),
    ColorChartData(x[5], const Color.fromRGBO(0x7A, 0x46, 0x28, 1)),
    ColorChartData(x[6], const Color.fromRGBO(0x63, 0x28, 0x2A, 1)),
    ColorChartData(x[7], const Color.fromRGBO(0x59, 0x59, 0x59, 1)),
  ];
  return SfCircularChart(
    // annotations: <CircularChartAnnotation>[
    //   CircularChartAnnotation(
    //     // angle: 0,
    //     // radius: '0%',
    //     widget: Column(
    //       children: [
    //         SizedBox(
    //           height: 100.h,
    //         ),
    //         Text("이번 달 쾌변율", style: AppleFont14_Grey600,),
    //         Text("${(x2 * 100).toStringAsFixed(0)}%",style: AppleFont36_Blue600,)
    //       ],
    //     ),
    //   ),
    // ],
    legend: Legend(isVisible: true, position: LegendPosition.bottom),
    series: <CircularSeries>[
      DoughnutSeries(
        dataSource: chartdatas,
        startAngle: 270,
        endAngle: 270,
        pointColorMapper: (data, index) {
          return data.color;
        },
        xValueMapper: (data, index) {
          return "";
        },
        yValueMapper: (data, index) {
          return data.y;
        },
        innerRadius: '75%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          builder: (data, point, series, pointIndex, seriesIndex) {
            return Text(
              (data.y * 100).toStringAsFixed(0) + "%",
              style: TextStyle(color: white, fontSize: 14),
            );
          },
        ),
      ),
    ],
  );
}

class ColorChartData {
  ColorChartData(this.y, this.color);
  final double y;
  final Color color;
}
