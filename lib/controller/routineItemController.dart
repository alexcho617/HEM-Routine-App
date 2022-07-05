import 'package:get/get.dart';
import '../models/routineItem.dart';

class RoutineItemController extends GetxController {
  RoutineItem item = RoutineItem(name: 'RoutineA', goalCount: 4);
  final list = List<RoutineItem>.generate(3, (int index) {
    return RoutineItem(name: '루틴 항목 이름 $index', goalCount: 4);
  });

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineItem itemToSwap = list.removeAt(oldIndex);
    list.insert(newIndex, itemToSwap);
  }
}
