class RoutineItem {
  RoutineItem({this.name, this.category, this.description, this.isChecked = false, this.isTapped = false, this.isAdded = false, this.isCustom = false});
  dynamic name;
  dynamic category;
  dynamic description;
  dynamic isChecked;//항목이 체크됐는지?
  dynamic isTapped;
  dynamic isAdded;//항목을 체크한 후에 추가까지 했는지. 만일 그렇다면 더 이상 추가하는 목록에서 보여지지 않음.
  dynamic isCustom;
}
