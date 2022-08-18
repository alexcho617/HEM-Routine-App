import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/services/firestore.dart';

//firestore.dart에 정의된 최근 7일,이번달, 지난 달 함수들 사용할것.
class ReportController extends GetxController {
  RxMap weekEvents = {}.obs;
  RxMap monthEvents = {}.obs;
  RxMap threeMonthsEvents = {}.obs;
  // RxMap sixMonthsEvents = {}.obs;
  var weekEventsKeys = [];
  //기획 4
  var sevenDayEventCount = '0'.obs;

  //기획 8
  // var thisMonthEventCount = '0'.obs; //이게 0이면 이번 달 기록이 없음
  // var wateryCount = '0'.obs;
  // var smoothCount = '0'.obs;
  // var hardCount = '0'.obs;
  RxList pieChartData = [].obs;

  //기획 9
  RxList lineChartData = [].obs;

  //기획 10
  //회붉초노갈고흑 순서
  RxList colorChartData7 = [].obs;
  RxList colorChartData30 = [].obs;
  RxList colorChartData90 = [].obs;

  RxList routineList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    weekEvents = await fetchPastSevenDaysEvent();
    await getWeeklyEventCount();

    monthEvents = await fetchThisMonthsEvent();
    // sixMonthsEvents = await fetchPreviousMonthsEvent(5);
    getPieChartData();
    lineChartData = await fetchSixMonthSmooth(5);
    routineList.value = await fetchAllRoutines();

    colorChartData7 = await fetchColorChartData(7);
    colorChartData30 = await fetchColorChartData(30);
    colorChartData90 = await fetchColorChartData(90);

    update();
  }

  Future<void> getWeeklyEventCount() async {
    var count = 0;
    weekEventsKeys = weekEvents.keys.toList();
    for (var key in weekEventsKeys) {
      //empty list 인 경우 대응해줘야함.
      List<CalendarEvent> events = weekEvents[key];
      count += events.length;
    }
    sevenDayEventCount.value = count.toString();
  }

//데이터 양이 크지 않기 때문에 기기에서 계산한다.
  Future<void> getPieChartData() async {
    int count = 0;
    int water = 0;
    int smooth = 0;
    int hard = 0;
    var keyList = monthEvents.keys.toList();
    //update
    for (var key in keyList) {
      List<CalendarEvent> events = monthEvents[key];
      count += events.length;
      for (CalendarEvent event in events) {
        if (event.type == '0' || event.type == '1') {
          water += 1;
        } else if (event.type == '2' ||
            event.type == '3' ||
            event.type == '4') {
          smooth += 1;
        } else {
          hard += 1;
        }
      }
    }
    if (count != 0) {
      //asign
      pieChartData.add(((water / count) * 100).round() / 100);
      pieChartData.add(((smooth / count) * 100).round() / 100);
      pieChartData.add(((hard / count) * 100).round() / 100);
    }
    // thisMonthEventCount.value = count.toString();
    // wateryCount.value = water.toString();
    // smoothCount.value = smooth.toString();
    // hardCount.value = hard.toString();
  }

  num getCompletedRoutines() {
    num com = 0;
    for (var i in routineList) {
      com += i.tryCount;
    }
    return com;
  }

  num getAvgRoutineCompletion() {
    num avg = 0.0;
    for (var i in routineList) {
      avg += i.averageComplete;
    }
    avg /= routineList.length;

    return avg;
  }
}
