import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';
import 'package:hem_routine_app/views/home.dart';
import '../../models/event.dart';
import '../../utils/calendarUtil.dart';

class NewCalendarEvent extends StatefulWidget {
  const NewCalendarEvent({Key? key}) : super(key: key);

  @override
  State<NewCalendarEvent> createState() => _NewCalendarEventState();
}

class _NewCalendarEventState extends State<NewCalendarEvent> {
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
            Row(
              children: [Text('Shape Select')],
            ),
            Row(
              children: [Text('Color Select')],
            ),
            Row(
              children: [Text('Hardness Select')],
            ),
            TextFormField(
              controller: eventTextController,
            ),
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                setState(
                  () {
                    if (eventTextController.text.isEmpty) {
                    } else {
                      if (controller.selectedEvents[controller.selectedDay] !=
                          null) {
                        controller.selectedEvents[controller.selectedDay]!.add(
                          UserEvent(
                              time: controller.selectedDay,
                              color: Colors.amber,
                              memo: eventTextController.text),
                        );

                        print(
                            controller.selectedEvents[controller.selectedDay]);
                      } else {
                        //listize and add
                        controller.selectedEvents[controller.selectedDay] = [
                          UserEvent(
                              time: controller.selectedDay,
                              color: Colors.amber,
                              memo: eventTextController.text),
                        ];
                      }
                      eventTextController.clear();
                    }
                  },
                );
                // Navigator.pop(context);
                return;
              },
            ),
          ]),
        ),
      ),
    );
  }
}
