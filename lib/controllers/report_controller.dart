import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendar_event.dart';
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
  var isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await refreshData();
    // weekEvents = await fetchPastSevenDaysEvent();
    // await getWeeklyEventCount();

    // monthEvents = await fetchThisMonthsEvent();
    // // sixMonthsEvents = await fetchPreviousMonthsEvent(5);
    // await getPieChartData();
    // lineChartData = await fetchSixMonthSmooth(5);
    // routineList.value = await fetchAllRoutines();

    // colorChartData7 = await fetchColorChartData(7);
    // colorChartData30 = await fetchColorChartData(30);
    // colorChartData90 = await fetchColorChartData(90);

    // update();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    weekEvents = await fetchPastSevenDaysEvent();
    await getWeeklyEventCount();

    monthEvents = await fetchThisMonthsEvent();
    pieChartData = await fetchPieChartData();
    lineChartData = await fetchLineChartData(5);
    routineList.value = await fetchAllRoutines();

    colorChartData7 = await fetchColorChartData(7);
    colorChartData30 = await fetchColorChartData(30);
    colorChartData90 = await fetchColorChartData(90);
    isLoading.value = false;

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

  num getCompletedRoutines() {
    num com = 0;
    for (var i in routineList) {
      com += i.tryCount;
    }
    return com;
  }

  num getAvgRoutineCompletion() {
    if (routineList.isEmpty) {
      return 0.0;
    }
    num avg = 0.0;
    for (var i in routineList) {
      avg += i.averageComplete;
    }
    avg /= routineList.length;
    return avg;
  }
}
