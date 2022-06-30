import 'package:flutter/material.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Calendar()),
    );
  }
}



