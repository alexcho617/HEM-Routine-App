import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void kangmin(context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInBack;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

// bool routineInit(String text, String uid) {
//   FirebaseFirestore.instance.collection('user/$uid/routine').add({
//                             'averageComplete': 0,
//                             'averageRating': 0,
//                             'name': text
//                           });
  
// }