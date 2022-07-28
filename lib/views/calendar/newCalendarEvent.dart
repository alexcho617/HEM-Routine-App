import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/views/home.dart';
import '../../models/calendarEvent.dart';
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
  var markerColor = 'yellow';

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
              children: [
                IconButton(
                    onPressed: () {
                      markerColor = 'yellow';
                    },
                    icon: Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    )),
                IconButton(
                    onPressed: () {
                      markerColor = 'red';
                    },
                    icon: Icon(
                      Icons.circle,
                      color: Colors.red,
                    ))
              ],
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
                if (eventTextController.text.isNotEmpty) {
                  if (controller.selectedEvents[controller.selectedDay] !=
                      null) {
                    setState(
                      () {
                        controller.selectedEvents[controller.selectedDay]!.add(
                          CalendarEvent(
                              time: controller.selectedDay,
                              //markerColor is selecting the icon image type
                              color: markerColor,
                              memo: eventTextController.text),
                        );
                      },
                    );

                    print(controller.selectedEvents[controller.selectedDay]
                        .toString());
                  } else {
                    //listize and add
                    setState(() {
                      controller.selectedEvents[controller.selectedDay] = [
                        CalendarEvent(
                            time: controller.selectedDay,
                            color: markerColor,
                            memo: eventTextController.text),
                      ];
                    });
                    print(controller.selectedEvents[controller.selectedDay]
                        .toString());
                  }
                  eventTextController.clear();
                }

                Navigator.pop(context);
                return;
              },
            ),
          ]),
        ),
      ),
    );
  }
}
