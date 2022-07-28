class CalendarEvent {
  CalendarEvent(
      {this.time,
      this.type,
      this.color,
      this.hardness,
      this.memo,
      this.iconCode});
  dynamic memo;
  dynamic time;
  dynamic type;
  dynamic color;
  dynamic hardness;
  dynamic iconCode;

  @override
  String toString() {
    return '\ntime:'+time.toString() +
        '\ncontents:' +
        '$type,' '$color,' '$hardness,' +
        '$memo'+'\niconCode:''$iconCode\n';
  }
}
