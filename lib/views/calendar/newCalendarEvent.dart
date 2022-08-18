import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'package:hem_routine_app/tableCalendar/src/widgets/custom_icon_button.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/setting/completed_routines.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../models/calendarEvent.dart';
import '../../utils/calendarUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewCalendarEvent extends StatefulWidget {
  const NewCalendarEvent({Key? key}) : super(key: key);

  @override
  State<NewCalendarEvent> createState() => _NewCalendarEventState();
}

class _NewCalendarEventState extends State<NewCalendarEvent> {
  Widget TypeButton(
      Image selectedImage, Image unSelectedImage, String label, String index) {
    return Column(
      children: [
        IconButton(
          icon: typeCode == index ? selectedImage : unSelectedImage,
          onPressed: () {
            setState(() {
              typeCode = index;
              iconCode = typeCode + colorCode + hardnessCode;
            });
          },
        ),
        Text(label)
      ],
    );
  }

  Widget ColorButton(
      Image selectedImage, Image unSelectedImage, String label, String index) {
    return Column(
      children: [
        IconButton(
          icon: colorCode == index ? selectedImage : unSelectedImage,
          onPressed: () {
            setState(() {
              colorCode = index;
              iconCode = typeCode + colorCode + hardnessCode;
            });
          },
        ),
        Text(label)
      ],
    );
  }

  Widget HardnessButton(
      Image selectedImage, Image unSelectedImage, String label, String index) {
    return Container(
      child: Column(
        children: [
          IconButton(
            iconSize: 64.sp,
            icon: hardnessCode == index ? selectedImage : unSelectedImage,
            onPressed: () {
              setState(() {
                hardnessCode = index;
                iconCode = typeCode + colorCode + hardnessCode;
              });
            },
          ),
          Text(label)
        ],
      ),
    );
  }

  //Event related
  var iconCode = '399';

  var markerType = 'smooth';
  var typeCode = '3';

  var markerColor = '';
  var colorCode = '9';

  var markerHardness = '';
  var hardnessCode = '9';

  TextEditingController eventTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CalendarController controller = Get.find();
    bool isLoading = true;
    return
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: background,
        //   foregroundColor: Colors.black,
        //   centerTitle: false,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);

        //     },
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           showDialog(
        //               context: context,
        //               builder: ((context) {
        //                 return deleteAlertDialog(() {
        //                   Get.back();
        //                 }, onPressed);
        //               }));
        //         },
        //         icon: Icon(Icons.delete_outline_rounded))
        //   ],
        //   title: Text('배변 기록'),
        // ),
        Column(
      children: [
        customAppBar(context, '배변 기록'),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 250.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: blue50,
                      borderRadius: BorderRadius.circular(15.sp)),
                  child: InkWell(
                    onTap: () => _showDatePicker(context),
                    child: Text(
                      textAlign: TextAlign.center,
                      DateFormat('yyyy-MM-dd, a hh시 mm분', 'ko_KR')
                          .format(controller.newEventTime),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0.sp),
                  alignment: Alignment.center,
                  child: Image(
                    width: 140.w,
                    height: 92.h,
                    image: AssetImage("assets/marker/$iconCode.png"),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text('배변 형태(묽기) 선택')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TypeButton(Image.asset('assets/button/type/00.png'),
                        Image.asset('assets/button/type/0.png'), '물변', '0'),
                    TypeButton(Image.asset('assets/button/type/11.png'),
                        Image.asset('assets/button/type/1.png'), '진흙변', '1'),
                    TypeButton(Image.asset('assets/button/type/22.png'),
                        Image.asset('assets/button/type/2.png'), '무른변', '2'),
                    TypeButton(Image.asset('assets/button/type/33.png'),
                        Image.asset('assets/button/type/3.png'), '매끈변', '3'),
                    TypeButton(Image.asset('assets/button/type/44.png'),
                        Image.asset('assets/button/type/4.png'), '금간변', '4'),
                    TypeButton(Image.asset('assets/button/type/55.png'),
                        Image.asset('assets/button/type/5.png'), '딱딱변', '5'),
                    TypeButton(Image.asset('assets/button/type/66.png'),
                        Image.asset('assets/button/type/6.png'), '토끼변', '6'),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    alignment: Alignment.centerLeft,
                    child: Text('배변 색 선택')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ColorButton(Image.asset('assets/button/color/00.png'),
                        Image.asset('assets/button/color/0.png'), '회색', '0'),
                    ColorButton(Image.asset('assets/button/color/11.png'),
                        Image.asset('assets/button/color/1.png'), '붉은색', '1'),
                    ColorButton(Image.asset('assets/button/color/22.png'),
                        Image.asset('assets/button/color/2.png'), '초록색', '2'),
                    ColorButton(Image.asset('assets/button/color/33.png'),
                        Image.asset('assets/button/color/3.png'), '노란색', '3'),
                    ColorButton(Image.asset('assets/button/color/44.png'),
                        Image.asset('assets/button/color/4.png'), '갈색', '4'),
                    ColorButton(Image.asset('assets/button/color/55.png'),
                        Image.asset('assets/button/color/5.png'), '고동색', '5'),
                    ColorButton(Image.asset('assets/button/color/66.png'),
                        Image.asset('assets/button/color/6.png'), '흑색', '6'),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    alignment: Alignment.centerLeft,
                    child: Text('배변감 선택')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HardnessButton(
                        Image.asset('assets/button/hardness/00.png'),
                        Image.asset('assets/button/hardness/0.png'),
                        '많이 불편',
                        '0'),
                    HardnessButton(Image.asset('assets/button/hardness/11.png'),
                        Image.asset('assets/button/hardness/1.png'), '불편', '1'),
                    HardnessButton(Image.asset('assets/button/hardness/22.png'),
                        Image.asset('assets/button/hardness/2.png'), '편함', '2'),
                    HardnessButton(
                        Image.asset('assets/button/hardness/33.png'),
                        Image.asset('assets/button/hardness/3.png'),
                        '매우 편함',
                        '3'),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    alignment: Alignment.centerLeft,
                    child: Text('메모')),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '메모 입력',
                      hintStyle: TextStyle(fontSize: 12.sp),
                    ),
                    controller: eventTextController,
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Container(
                  alignment: Alignment.center,
                  child: saveButtonBlue(() async {
                    LoginService loginService = Get.find();
                    try {
                      CalendarEvent newEvent = CalendarEvent(
                          time: controller.newEventTime,
                          color: colorCode,
                          type: typeCode,
                          hardness: hardnessCode,
                          iconCode: iconCode,
                          memo: eventTextController.text);
                      await addEventToCalendar(
                          newEvent, loginService.auth.value.currentUser!.uid);

                      controller.eventsLibrary = await fetchAllEvents();
                      controller.update();
                      kangminBack(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return calendarAlertDialog(newEvent, () {
                              //on button Pressed
                              Get.back();
                            });
                          });
                    } on Exception catch (e) {
                      kangminBack(context);
                      print(e);
                    }

                    eventTextController.clear();

                    return;
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    CalendarController controller = Get.find();
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 370,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    //cannot add datetime and year at the same time. otherwise separte year+date from time
                    child: CupertinoDatePicker(
                        initialDateTime: controller.newEventTime,
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (val) {
                          controller.newEventTime = val;
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('저장'),
                    onPressed: () {
                      setState(() {
                        //save time
                      });
                      Navigator.of(context
                              .findAncestorStateOfType<HomePageState>()!
                              .context)
                          .maybePop();
                    },
                  )
                ],
              ),
            ));
  }
}


// CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.dateAndTime,
//               onDateTimeChanged: (value) {
                
//               },
//               initialDateTime: DateTime.now(),
//             ),