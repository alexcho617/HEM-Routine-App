import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/models/routine.dart';

class RoutineCompletedController extends GetxController {
  LoginService loginService = Get.find();
  late QuerySnapshot routineCompleted;
  var routines = [].obs;

  @override
  void onInit() async {
    super.onInit();
    routineCompleted = await FirebaseFirestore.instance
        .collection('user')
        .doc(loginService.auth.value.currentUser!.uid)
        .collection('routine')
        .get();

    await getData();
    print(routines);
  }

  Future<void> getData() async {
    routineCompleted.docs.forEach((doc) {
      Routine routine = Routine();
      routine.averageComplete = doc.get("averageComplete");
      routine.averageRating = doc.get("averageRating");
      routine.name = doc.get("name");
      routine.routineItem = doc.get("routineItem");
      routine.days = doc.get("days");
      routine.goals = doc.get("goals");
      routine.isActive = doc.get("isActive");
      routine.tryCount = doc.get("tryCount");
      //

      routines.add(routine);
      
    });
  }
}
