class CalendarEvent {
  CalendarEvent(
      {this.time,
      this.color,
      this.type,
      this.hardness,
      this.memo,
      this.iconCode});
  dynamic memo;
  dynamic time;
  dynamic color;
  dynamic type;
  dynamic hardness;
  dynamic iconCode;

  @override
  String toString() {
    return time.toString()+'\n'+'$color\n'+'$memo\n';
  }
}
