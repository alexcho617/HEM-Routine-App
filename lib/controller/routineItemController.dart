import 'package:get/get.dart';
import '../models/routineItem.dart';

class RoutineItemController extends GetxController {
  // This code is for Testing
  // Link to FireStore and get RoutineItems and eventCount
  final countList = List<int>.generate(6, (index) => (index + 1) * 2);
  final list = List<RoutineItem>.generate(6, (int index) {
    return RoutineItem(name: '루틴 항목 이름 $index', goalCount: (index + 2) * 3);
  });

  /*
  // TODO : Change to this code
  final List<int> countList;
  final List<RoutineItem> list;
  RoutineItemController(this.list, this.countList);
  */

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineItem itemToSwap = list.removeAt(oldIndex);
    list.insert(newIndex, itemToSwap);
  }

  double getPercent(int eventCount, int goalCount) {
    double eCount = eventCount.toDouble();
    double gCount = goalCount.toDouble();

    double percent = eCount / gCount;
    return percent;
  }

  void onPressed() {
    // TODO: make report
    // TODO: increse count in countList
  }
}
