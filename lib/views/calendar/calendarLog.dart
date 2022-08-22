import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/bottom_pop_up/routineLog.dart';
import 'package:hem_routine_app/views/calendar/editCalendarEvent.dart';
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
                        controller.getCalendarLog();
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
                        controller.getCalendarLog();
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
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
                    child: GetBuilder(
                        init: controller,
                        builder: (_) {
                          return ListView.separated(
                            itemCount: controller.events!.length,
                            // physics: NeverScrollableScrollPhysics(),
                            // physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.editIndex = index;
                                          kangmin(context, EditCalendarEvent());
                                        },
                                        icon: Icon(
                                          Icons.edit_note,
                                          color: black,
                                        ),
                                      )
                                    ],
                                  ),
                                  Image(
                                    width: 160.w,
                                    height: 105.h,
                                    image: AssetImage(
                                        'assets/marker/${controller.events![index].iconCode}.png'),
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  controller.events![index].type != null
                                      ? Text(
                                          parseTypeCode(
                                              controller.events![index].type),
                                          style: AppleFont16_BlackBold,
                                        )
                                      : Text('없음'),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 21.0),
                                    child: Divider(
                                      color: Color.fromARGB(255, 193, 185, 185),
                                      thickness: 1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 28.0.sp),
                                    // height: 120.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Row(
                                          children: [
                                            Text('배변색',
                                                style: AppleFont14_Grey600),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            controller.events![index].color !=
                                                    null
                                                ? Text(
                                                    parseColorCode(controller
                                                        .events![index].color),
                                                    style: AppleFont14_Black)
                                                : Text('없음'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          children: [
                                            Text('배변감',
                                                style: AppleFont14_Grey600),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            controller.events![index]
                                                        .hardness !=
                                                    null
                                                ? Text(
                                                    parseHardnessCode(controller
                                                        .events![index]
                                                        .hardness),
                                                    style: AppleFont14_Black)
                                                : Text('없음'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          children: [
                                            Text('메모',
                                                style: AppleFont14_Grey600),
                                            SizedBox(
                                              width: 32.w,
                                            ),
                                            Flexible(
                                                child: Text(
                                                    controller
                                                        .events![index].memo,
                                                    overflow:
                                                        TextOverflow.clip))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
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
                                            controller.events![index].time !=
                                                    null
                                                ? Text(
                                                    parseTime(controller
                                                        .events![index].time),
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
                          );
                        }),
                  )
          ],
        ));
  }
}
