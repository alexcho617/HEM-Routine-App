import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/calendarUtil.dart';
import '../../widgets/widgets.dart';

class CalendarLog extends StatefulWidget {
  const CalendarLog({Key? key}) : super(key: key);

  @override
  State<CalendarLog> createState() => _CalendarLogState();
}

class _CalendarLogState extends State<CalendarLog> {
  @override
  Widget build(BuildContext context) {
    CalendarController controller = Get.find();
    List<CalendarEvent>? events =
        controller.getEventsfromDay(parseDay(controller.focusedDate.value));
    return calendarLogBottomSheet(
        context,
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 45.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    if (controller.focusedDate.value.isAfter(kFirstDay)) {
                      setState(() {
                        controller.focusedDate.value = controller
                            .focusedDate.value
                            .subtract(Duration(days: 1));
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  parseDayToString(controller.focusedDate.value),

                  // '${controller.focusedDate.year.toString()}년 ${controller.newEventTime.month.toString()}월 ${controller.newEventTime.day.toString()}일',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    if (controller.focusedDate.value.isBefore(kLastDay)) {
                      setState(() {
                        controller.focusedDate.value =
                            controller.focusedDate.value.add(Duration(days: 1));
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            TextButton(
              child: Text('PrintEvents'),
              onPressed: () => print(controller
                  .getEventsfromDay(parseDay(controller.focusedDate.value))),
            ),
            SizedBox(
              height: 33.h,
            ),
            controller.getEventsfromDay(
                        parseDay(controller.focusedDate.value)) ==
                    null
                ? Container(
                    child: Column(
                    children: [
                      Image(
                          width: 160.w,
                          height: 105.h,
                          image: AssetImage('assets/appIcon.png')),
                      Text('기록이 없습니다.'),
                    ],
                  ))
                : Expanded(
                    child: ListView.separated(
                      itemCount: controller
                          .getEventsfromDay(
                              parseDay(controller.focusedDate.value))!
                          .length,
                      // physics: NeverScrollableScrollPhysics(),
                      // physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Image(
                              width: 160.w,
                              height: 105.h,
                              image: AssetImage(
                                  'assets/marker/${events![index].iconCode}.png'),
                            ),
                            Text(events[index].type),
                            Divider(
                              thickness: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(events[index].color),
                                Text(events[index].hardness),
                                Text(events[index].memo ?? 'no memo'),
                                Text(parseDayToString(events[index].time)),
                              ],
                            ),
                          ],
                        );
                      },

                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          color: const Color.fromRGBO(0x60, 0x60, 0x60, 1),
                          thickness: 2,
                        ),
                      ),
                    ),
                  )
          ],
        ));
  }
}
