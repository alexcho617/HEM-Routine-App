import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
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
                Text(parseDayToString(controller.focusedDate.value),

                    // '${controller.focusedDate.year.toString()}년 ${controller.newEventTime.month.toString()}월 ${controller.newEventTime.day.toString()}일',
                    style: AppleFont16_BlackBold),
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
            // TextButton(
            //   child: Text('PrintEvents'),
            //   onPressed: () => print(controller
            //       .getEventsfromDay(parseDay(controller.focusedDate.value))),
            // ),
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
                      Text(
                        '기록이 없습니다.',
                        style: AppleFont16_BlackBold,
                      ),
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
                            SizedBox(
                              height: 8.0.h,
                            ),
                            events[index].type != null
                                ? Text(
                                    parseTypeCode(events[index].type),
                                    style: AppleFont16_BlackBold,
                                  )
                                : Text('없음'),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 21.0),
                              child: Divider(
                                color: Color.fromARGB(255, 193, 185, 185),
                                thickness: 1,
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 28.0.sp),
                              // height: 120.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Text('배변색', style: AppleFont14_Grey600),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      events[index].color != null
                                          ? Text(
                                              parseColorCode(
                                                  events[index].color),
                                              style: AppleFont14_Black)
                                          : Text('없음'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('배변감', style: AppleFont14_Grey600),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      events[index].hardness != null
                                          ? Text(
                                              parseHardnessCode(
                                                  events[index].hardness),
                                              style: AppleFont14_Black)
                                          : Text('없음'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('메모', style: AppleFont14_Grey600),
                                      SizedBox(
                                        width: 32.w,
                                      ),
                                      Flexible(child: Text(events[index].memo,overflow: TextOverflow.clip))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_alarm,
                                        color: grey600,
                                      ),
                                      SizedBox(
                                        width: 34.w,
                                      ),
                                      events[index].time != null
                                          ? Text(parseTime(events[index].time),
                                              style: AppleFont14_Black)
                                          : Text('없음'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 21.0.w, vertical: 8.0.h),
                        child: Divider(
                          color: Color.fromRGBO(0x60, 0x60, 0x60, 1),
                          thickness: 2,
                        ),
                      ),
                    ),
                  )
          ],
        ));
  }
}
