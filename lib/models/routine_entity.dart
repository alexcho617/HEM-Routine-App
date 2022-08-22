class RoutineEntity {
  RoutineEntity({required this.name, this.goalCount = 0, required this.index});
  dynamic name;
  dynamic goalCount;
  dynamic index;

  void printElements(){
    print('이름 : $name, goalCount : $goalCount, index : $index\n');
  }
}
