import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

Widget noDataWidget() {
  return Column(
    children: [
      SizedBox(height: 12.h),
      Image.asset(
        'assets/appIcon.png',
        width: 160.w,
      ),
      Text(
        "기록이 없습니다.",
        style: AppleFont16_Black,
      ),
    ],
  );
}

Widget circularAnalysisChart(RxList x) {
  if (x.isEmpty) {
    return noDataWidget();
  }
  List<AnalysisChartData> chartdatas = [
    AnalysisChartData("묽은변", x[0], color: blue50),
    AnalysisChartData("쾌변", x[1], color: blue600),
    AnalysisChartData("단단한 변", x[2], color: blue200),
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
              "${(x[1] * 100).toStringAsFixed(0)}%",
              style: AppleFont36_Blue600,
            )
          ],
        ),
      ),
    ],
    legend: Legend(isVisible: true, position: LegendPosition.bottom, toggleSeriesVisibility: false),
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
            if (data.y == 0) {
              return const Text("");
            } else {
              return Text(
                (data.y * 100).toStringAsFixed(0) + "%",
                style: TextStyle(
                    color: pointIndex == 0 ? blue600 : white, fontSize: 14),
              );
            }
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

Widget circularColorChart(RxList x) {
  if (x.isEmpty) {
    return noDataWidget();
  }
  List<ColorChartData> chartdatas = [
    ColorChartData(x[0], const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1)),
    ColorChartData(x[1], const Color.fromRGBO(0xDC, 0x6D, 0x69, 1)),
    ColorChartData(x[2], const Color.fromRGBO(0x88, 0xA8, 0x83, 1)),
    ColorChartData(x[3], const Color.fromRGBO(0xF6, 0xC1, 0x43, 1)),
    ColorChartData(x[4], const Color.fromRGBO(0x7A, 0x46, 0x28, 1)),
    ColorChartData(x[5], const Color.fromRGBO(0x63, 0x28, 0x2A, 1)),
    ColorChartData(x[6], const Color.fromRGBO(0x59, 0x59, 0x59, 1)),
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
    legend: Legend(isVisible: false),
    series: <CircularSeries>[
      DoughnutSeries(
        animationDelay: 0,
        animationDuration: 100,
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
        innerRadius: '60%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          builder: (data, point, series, pointIndex, seriesIndex) {
            if (data.y == 0) {
              return const Text("");
            } else {
              return Text(
                (data.y * 100).toStringAsFixed(0) + "%",
                style: TextStyle(color: white, fontSize: 14),
              );
            }
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

// class ReportWidgetTestPage extends StatefulWidget {
//   const ReportWidgetTestPage({Key? key}) : super(key: key);

//   @override
//   State<ReportWidgetTestPage> createState() => _ReportWidgetTestPageState();
// }

// //TEST CODE
// class _ReportWidgetTestPageState extends State<ReportWidgetTestPage> {
//   RxList hardness = [0.10, 0.67, 0.23].obs;
//   RxList colors = [0.10, 0.0, 0.25, 0.30, 0.20, 0.05, 0.05].obs;
//   RxList lines = [0.0, 0.0, 1.0, 0.0, 0.41, 0.67].obs;
//   // 회색, 붉은색, 초록색, 노란색, 갈색, 고동색, 흑색
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               circularAnalysisChart(hardness),
//               circularColorChart(colors),
//               // syncLineChart(),
//               monthlyRateChart(lines),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget syncLineChart() {
//   return SfSparkLineChart(
//     marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
//     labelDisplayMode: SparkChartLabelDisplayMode.all,
//     data: <double>[1, 5, 2, 0, 6, 7, 0],
//   );
// }

List<LineChartBarData> lineBarsData(RxList x) {
  return [
    LineChartBarData(
      spots: [
        FlSpot(0, x[0]),
        FlSpot(1, x[1]),
        FlSpot(2, x[2]),
        FlSpot(3, x[3]),
        FlSpot(4, x[4]),
        FlSpot(5, x[5]),
      ],
      barWidth: 0.8.r,
      color: black,
      dotData: FlDotData(
        getDotPainter:
            (FlSpot spot, double xPercentage, LineChartBarData bar, int index) {
          return FlDotCirclePainter(
            color: blue200,
          );
        },
      ),
    ),
  ];
}

Widget monthlyRateChart(RxList x) {
  if (x.isEmpty) {
    return const CircularProgressIndicator();
  }
  final lineChartBarsData = lineBarsData(x);
  final showIndex = [0, 1, 2, 3, 4, 5];
  return SizedBox(
    width: 500,
    height: 250,
    child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
              enabled: false,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                        (touchedSpot.y * 100).toStringAsFixed(0) + "%",
                        AppleFont14_Black);
                  }).toList();
                },
              )),
          betweenBarsData: [
            BetweenBarsData(fromIndex: 0, toIndex: 0, color: Colors.black)
          ],
          showingTooltipIndicators: showIndex.map((index) {
            if (lineChartBarsData[0].spots[index].y == 0) {
              return ShowingTooltipIndicators([]);
            } else {
              return ShowingTooltipIndicators([
                LineBarSpot(lineChartBarsData[0], index,
                    lineChartBarsData[0].spots[index])
              ]);
            }
          }).toList(),
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: black,
              ),
            ),
          ),
          minY: 0,
          maxY: 1,
          lineBarsData: lineChartBarsData,
        ),
      ),
    ),
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  int month = DateTime.now().month;
  const style = TextStyle();
  String text;
  text = (month - (5 - value).toInt()).toString();
  return SideTitleWidget(
      child: Text(text + "월", style: style), axisSide: meta.axisSide);
}
