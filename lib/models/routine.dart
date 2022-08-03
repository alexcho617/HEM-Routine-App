import 'package:get/get.dart';

class Routine {
  Routine({
    this.averageComplete,
    this.averageRating,
    this.name,
    this.routineItem,
    this.days,
    this.goals,
    this.isActive,
    this.tryCount,
    this.id,
  });
  dynamic averageComplete; // percentage itself (int)
  dynamic averageRating; // double
  dynamic name;
  dynamic routineItem; // List of RoutineItem Name(String[])
  dynamic goals; // List of RoutineItem goals(int[])
  dynamic isActive; // bool
  dynamic days;
  dynamic tryCount;
  dynamic id; // used for navigating to routine detail page
/*
  factory Routine.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Routine(
      averageComplete: data?['averageComplete'],
      averageRating: data?['averageRating'],
      name: data?['name'],
      routineItem: data?['routineItem'],
      days: data?['days'],
      goals: data?['goals'],
      isActive: data?['isActive'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (averageComplete != null) "averageComplete": averageComplete,
      if (averageRating != null) "averageRating": averageRating,
      if (name != null) "name": name,
      if (routineItem != null) "routineItem": routineItem,
      if (days != null) "days": days,
      if (goals != null) "goals": goals,
      if (isActive != null) "isActive": isActive,
    };
  }

  */
}
