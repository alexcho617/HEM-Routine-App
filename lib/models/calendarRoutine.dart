class CalendarRoutine {
  CalendarRoutine({this.startDate, this.endDate, this.duration, this.name});

  dynamic startDate;
  dynamic endDate;
  dynamic duration;
  dynamic name;

  @override
  String toString() {
    return '\nstartDate:' +
        startDate.toString() +
        '\nendDate:' +
        endDate.toString() +
        '\nduration:'+duration.toString() +
        '\nname:'+name;
  }
}
