//TODO: routineOffController의 항목이 추가되는 대로 반영하기 또 순서도 마찬가지.
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import '../models/routineEtity.dart';

class RoutineEntityController extends GetxController {
  List<RoutineEntity> routineEntities = [];
  int addedRoutineItemCount = 0;
  final inputController = TextEditingController();

  void buildRoutineEntities(){
    RoutineOffController controller = Get.find();
    for (int i = 0; i < controller.routineItems.length; i++) {

      if(controller.routineItems[i].isChecked == true && controller.routineItems[i].isAdded == false){
        controller.routineItems[i].isAdded = true;
        //index는 reorderable의 구동방식을 이해하고 해야겠다.
        routineEntities.add(RoutineEntity(name: controller.routineItems[i].name, index: addedRoutineItemCount++));
      }
    }
    update();
  }

  void deleteRoutineEntities(int index){
    RoutineOffController controller = Get.find();
    controller.routineItems[index].isAdded = false;
    routineEntities.removeWhere((element) => element.name == controller.routineItems[index].name);
    addedRoutineItemCount--;
    update();
  }
  
    itemReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final RoutineEntity itemToSwap = routineEntities.removeAt(oldIndex);
    routineEntities.insert(newIndex, itemToSwap);
    //여기서 바로 write를 해야 한다.
  }
}
