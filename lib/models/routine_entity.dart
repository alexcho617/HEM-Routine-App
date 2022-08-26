import 'package:flutter/foundation.dart';

class RoutineEntity {
  RoutineEntity({required this.name, this.goalCount = 0, required this.index});
  dynamic name;
  dynamic goalCount;
  dynamic index;

  void printElements(){
    if (kDebugMode) {
      print('이름 : $name, goalCount : $goalCount, index : $index\n');
    }
  }
}
