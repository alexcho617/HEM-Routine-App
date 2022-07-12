import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addEventToCalendar(CalendarEvent newEvent, String uid) async {
  CollectionReference eventReference =
      _firestore.collection('user').doc(uid).collection('Events');

  //add document since doc id can be auto generated
  await eventReference.add(({
    'time': newEvent.time,
    'color': newEvent.time,
    'type': newEvent.type,
    'hardness': newEvent.hardness
  }));
}

// Future<List<CalendarEvent>> fetchEvent(String uid) async {
Future<QuerySnapshot> fetchEvent(String uid) async {
  CollectionReference eventCollectionReference =
      _firestore.collection('user').doc(uid).collection('Events');
  // CalendarEvent singleEvent = CalendarEvent();

  // List<CalendarEvent> calendarEvents = [];
  // await eventCollectionReference.doc().get().then((DocumentSnapshot ds) {
  //   singleEvent.color = ds.get("color");
  //   singleEvent.hardness = ds.get("hardness");
  //   singleEvent.time = ds.get("time");
  //   singleEvent.type = ds.get("type");
  //   calendarEvents.add(singleEvent);
  // });

  // return calendarEvents;
  return eventCollectionReference.get();
}
