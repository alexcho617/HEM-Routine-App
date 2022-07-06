import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hem_routine_app/utils/calendarUtil.dart';

class EventController extends GetxController {
  Map<DateTime, List<Event>> selectedEvents = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDate = DateTime.now();

  List<dynamic>? getEventsfromDay(DateTime? date) {
    return selectedEvents[date];
  }
}
