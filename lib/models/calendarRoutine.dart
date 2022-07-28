import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarRoutine {
  CalendarRoutine({this.startDate, this.endDate, this.duration, this.name});

  dynamic startDate;
  dynamic endDate;
  dynamic duration;
  dynamic name;

  factory CalendarRoutine.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CalendarRoutine(
      startDate: data?['startDate'],
      endDate: data?['endDate'],
      duration: data?['duration'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (startDate != null) "startDate": startDate,
      if (endDate != null) "endDate": endDate,
      if (duration != null) "duration": duration,
      if (name != null) "name": name,
    };
  }
}
