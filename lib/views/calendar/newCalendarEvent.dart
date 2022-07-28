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
  var markerType = 'smooth';
  var typeCode = '0';

  var markerColor = 'yellow';
  var colorCode = '0';

  var markerHardness = 'good';
  var hardnessCode = '0';

  TextEditingController eventTextController = TextEditingController();

  var iconCode = '000';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(controller.selectedDay.toString()),
              ClipOval(
                child: Image(
                  image: AssetImage("assets/$iconCode.png"),
                ),
              ),
              Text('배변 형태(묽기) 선택'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        markerType = 'smooth';
                        typeCode = '0';
                      },
                      child: Text('매끈변')),
                  TextButton(
                      onPressed: () {
                        markerType = 'hard';
                        typeCode = '1';
                      },
                      child: Text('딱딱변'))
                ],
              ),
              Text('배변 색 선택'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        markerColor = 'yellow';
                        colorCode = '0';
                      },
                      icon: Icon(
                        Icons.circle,
                        color: Colors.yellow,
                      )),
                  IconButton(
                      onPressed: () {
                        markerColor = 'red';
                        colorCode = '1';
                      },
                      icon: Icon(
                        Icons.circle,
                        color: Colors.red,
                      ))
                ],
              ),
              Text('배변감'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        markerHardness = 'good';
                        hardnessCode = '0';
                      },
                      child: Text('불편')),
                  TextButton(
                      onPressed: () {
                        markerHardness = 'bad';
                        hardnessCode = '1';
                      },
                      child: Text('편함'))
                ],
              ),
              Text('메모'),
              TextFormField(
                controller: eventTextController,
              ),
              TextButton(
                child: Text("저장"),
                onPressed: () {
                  //An event already exists in the day
                  if (controller.selectedEvents[controller.selectedDay] !=
                      null) {
                    setState(
                      () {
                        iconCode = typeCode + colorCode + hardnessCode;
                        controller.selectedEvents[controller.selectedDay]!.add(
                          CalendarEvent(
                              time: controller.selectedDay,
                              color: markerColor,
                              type: markerType,
                              hardness: markerHardness,
                              iconCode: iconCode,
                              memo: eventTextController.text),
                        );
                      },
                    );
                    print(controller.selectedEvents[controller.selectedDay]
                        .toString());
                  }
                  //No event exists in the day
                  else {
                    setState(() {
                      iconCode = typeCode + colorCode + hardnessCode;
                      controller.selectedEvents[controller.selectedDay] = [
                        CalendarEvent(
                            time: controller.selectedDay,
                            color: markerColor,
                            type: markerType,
                            hardness: markerHardness,
                            iconCode: iconCode,
                            memo: eventTextController.text),
                      ];
                    });
                    print(controller.selectedEvents[controller.selectedDay]
                        .toString());
                  }
                  eventTextController.clear();

                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
