import 'package:get/get.dart';
import '../models/routineItem.dart';

class RoutineItemController extends GetxController {
  RoutineItem item = RoutineItem(name: 'RoutineA', goalCount: 4);
  var list = List<RoutineItem>.generate(3, (int index) {
    return RoutineItem(name: '루틴 $index', goalCount: 4);
  }).obs;

  itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= -1;
    }
    final RoutineItem itemToSwap = list.value.removeAt(oldIndex);
    list.insert(newIndex, itemToSwap);
  }
}
