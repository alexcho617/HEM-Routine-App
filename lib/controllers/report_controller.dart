import 'package:get/get.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/services/firestore.dart';

//firestore.dart에 정의된 최근 7일,이번달, 지난 달 함수들 사용할것.
class ReportController extends GetxController {
  RxMap weekEvents = {}.obs;
  RxMap monthEvents = {}.obs;
  RxMap threeMonthsEvents = {}.obs;
  RxMap sixMonthsEvents = {}.obs;
  var sevenDayEventCount = '0'.obs;
  var thisMonthEventCount = '0'.obs;

  @override
  void onInit() async {
    super.onInit();
    weekEvents = await fetchPastSevenDaysEvent();
    monthEvents = await fetchThisMonthsEvent();

    sevenDayEventCount.value = await getSevenDayEventNumber();
    thisMonthEventCount.value = await getThisMonthsEventNumber();

    update();
  }

  Future<String> getSevenDayEventNumber() async {
    var count = 0;
    var keyList = weekEvents.keys.toList();
    for (var key in keyList) {
      List<CalendarEvent> events = weekEvents[key];
      count += events.length;
    }
    return count.toString();
  }

  Future<String> getThisMonthsEventNumber() async {
    var count = 0;
    var keyList = monthEvents.keys.toList();
    for (var key in keyList) {
      List<CalendarEvent> events = monthEvents[key];
      count += events.length;
    }
    return count.toString();
  }
}