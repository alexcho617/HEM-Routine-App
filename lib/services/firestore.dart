import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/models/event.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addEventToCalendar(UserEvent newEvent, String uid) async {
  CollectionReference events =
      _firestore.collection('user').doc(uid).collection('Events');

  //add document since doc id can be auto generated
  await events.add(({
    'time': newEvent.time,
    'color': newEvent.time,
    'type': newEvent.type,
    'hardness': newEvent.hardness
  }));
}
