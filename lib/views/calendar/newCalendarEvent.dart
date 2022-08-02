import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/setting/completed_routines.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../models/calendarEvent.dart';
import '../../utils/calendarUtil.dart';

class NewCalendarEvent extends StatefulWidget {
  const NewCalendarEvent({Key? key}) : super(key: key);

  @override
  State<NewCalendarEvent> createState() => _NewCalendarEventState();
}

class _NewCalendarEventState extends State<NewCalendarEvent> {
  //바뀌지 않는 데이터를 굳이 동적으로 런타임에 만들어야 할까?
  var typeList = ['물변', '진흙변', '무른변', '매끈변', '금간변', '딱딱변', '토끼변'];
  var typeIconList = [
    '000.png',
    '000.png',
    '000.png',
    '000.png',
    '000.png',
    '000.png',
    '000.png'
  ];
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
    CalendarController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: background,
        foregroundColor: Colors.black,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return deleteAlertDialog(() {
                        Get.back();
                      }, onPressed);
                    }));
              },
              icon: Icon(Icons.delete_outline_rounded))
        ],
        title: Text('배변 기록'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(controller.selectedDay.toString()),
            ClipOval(
              child: Image(
                width: 140.w,
                height: 92.h,
                image: AssetImage("assets/marker/$iconCode.png"),
              ),
            ),
            Text('배변 형태(묽기) 선택'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/button/type/0.png'),
                        onPressed: () {
                          setState(() {
                            markerType = 'smooth';
                            typeCode = '0';
                            iconCode = typeCode + colorCode + hardnessCode;
                          });
                        },
                      ),
                      Text('매끈변')
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        markerType = 'hard';
                        typeCode = '1';
                        iconCode = typeCode + colorCode + hardnessCode;
                      });
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
                      setState(() {
                        markerColor = 'yellow';
                        colorCode = '0';
                        iconCode = typeCode + colorCode + hardnessCode;
                      });
                    },
                    icon: Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        markerColor = 'red';
                        colorCode = '1';
                        iconCode = typeCode + colorCode + hardnessCode;
                      });
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
                      setState(() {
                        markerHardness = 'good';
                        hardnessCode = '0';
                        iconCode = typeCode + colorCode + hardnessCode;
                      });
                    },
                    child: Text('불편')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        markerHardness = 'bad';
                        hardnessCode = '1';
                        iconCode = typeCode + colorCode + hardnessCode;
                      });
                    },
                    child: Text('편함'))
              ],
            ),
            Text('메모'),
            TextFormField(
              decoration: InputDecoration(hintText: '메모 입력'),
              controller: eventTextController,
            ),
            SizedBox(
              height: 26.h,
            ),
            saveButtonBlue(() {
//An event already exists in the day
              if (controller.selectedEvents[controller.selectedDay] != null) {
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
            }),
          ],
        ),
      ),
    );
  }
}
