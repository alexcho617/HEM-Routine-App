import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';

import '../../utils/calendarUtil.dart';

class NewCalendarEvent extends StatelessWidget {
  NewCalendarEvent({Key? key}) : super(key: key);

  //Event related
  TextEditingController eventTextController = TextEditingController();
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    EventController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('배변 기록'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline_rounded))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Text('Time'),
            ClipOval(
              child: Image(
                image: AssetImage("assets/characterIconYellow.png"),
              ),
            ),
            TextFormField(
              controller: eventTextController,
            ),
           
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                if (eventTextController.text.isEmpty) {
                } else {
                  if (controller.selectedEvents[controller.selectedDay] !=
                      null) {
                    controller.selectedEvents[controller.selectedDay]!.add(
                      Event(title: eventTextController.text),
                    );

                    print(controller.selectedEvents[controller.selectedDay]);
                  } else {
                    controller.selectedEvents[controller.selectedDay] = [
                      Event(title: eventTextController.text)
                    ];
                  }
                }
                Navigator.pop(context);
                eventTextController.clear();
                return;
              },
            ),
          ]),
        ),
      ),
    );
  }
}
