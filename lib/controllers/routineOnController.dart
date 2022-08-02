import 'package:get/get.dart';
import 'package:hem_routine_app/models/routineEntity.dart';
import '../models/routineItem.dart';

class RoutineOnController extends GetxController {
  //얘네는 isactive이면...!
  //TODO: 결국 여기에 entity도 합쳐야 겠다.
  // This code is for Testing
  // Link to FireStore and get RoutineItems and eventCount
  final countList = List<int>.generate(12, (index) => index * 5);
  final routineItems = List<RoutineEntity>.generate(12, (int index) {
    return RoutineEntity(name: '루틴 항목 이름 $index', goalCount: (index + 1) * 7, index: index);
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
    final RoutineEntity itemToSwap = routineItems.removeAt(oldIndex);
    routineItems.insert(newIndex, itemToSwap);
    // print(routineItems);
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
