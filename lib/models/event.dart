class Event {
  Event({this.eventTime, this.name});
  dynamic eventTime;
  dynamic name;

  @override
  String toString() {
    return "(name: $name, eventTime : $eventTime)";
  }
}
