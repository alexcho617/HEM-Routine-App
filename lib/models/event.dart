import 'package:flutter/material.dart';

class UserEvent {
  UserEvent({required this.time, required this.color, this.type, this.hardness, this.memo});
  var memo;
  DateTime time;
  Color color;
  var type;
  var hardness;
}
