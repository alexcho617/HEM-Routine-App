// ignore_for_file: prefer_const_constructors

/**
 * 일단은 월 별로 데이터를 새로 받아와서 그리는 방식으로 해야함.
 * 필요한 데이터는 uid, events of the month -> firestore에서 월별로 구별 할 지 아니면 timestamp 를 이용 해서 해당 월만 받아올지?
 * Event time 가지고 해당 월 데이터만 가져오는 쪽으로 해보자.
 * 
 * 하루하루의 위젯을 만들고 Wrap + Row로 중간 부분을 만든다. 헤더와 바디 따로 구현
 * 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/models/calendarEvent.dart';
import 'package:hem_routine_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomCalendar extends StatelessWidget {
  CustomCalendar({Key? key}) : super(key: key);
  String uid = 'user';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Year'),
        FutureBuilder(
          future: fetchEvent(uid),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // Map<String, dynamic> data =
                //     snapshot.data!.data() as Map<String, dynamic>;
                List<Widget> _days = [];
                snapshot.data!.docs.forEach((doc) {
                  _days.add(dayCard(doc['day'], doc['eventCount'],
                      doc['isRoutine'], Icons.abc));
                });
                return Wrap(
                  children: _days,
                ); //use itembuilder???
              }
            } else {
              return Container(
                width: 100,
                height: 100,
                color: Colors.red,
              );
            }
          }),
        )
      ],
    );
  }

  dynamic onMonthChanged() {
    //reload calendar data
  }
  List<DropdownMenuItem> menuItems = [
    DropdownMenuItem(child: Text('1')),
    DropdownMenuItem(child: Text('2')),
    DropdownMenuItem(child: Text('3')),
  ];
  // for (var i = 0; i < 12; i++) {
  //   menu.add(DropdownMenuItem(
  //     child: Text('1'),
  //   ));
  // }

  Widget dayCard(
      dynamic day, dynamic eventCount, bool isRoutine, dynamic icon) {
    return Container(
      width: 55.w,
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [Icon(icon), Text(day.toString())],
          ),
          Stack(
            children: [
              Container(color: isRoutine ? Colors.blue : Colors.red),
              Text('${eventCount}'),
            ],
          )
        ],
      ),
    );
  }
}




 // DropdownButton(items: menuItems, onChanged: onMonthChanged()),
        // Wrap(

        //   //future builder ? use firebase event collection as future, then return wrap widgets.
        //   children: [
        //     dayCard(1, 2, true, Icons.circle),
        //     dayCard(2, 2, false, Icons.circle),
        //     dayCard(3, 2, true, Icons.circle),
        //     dayCard(4, 2, true, Icons.circle),
        //     dayCard(5, 2, true, Icons.circle),
        //     dayCard(6, 2, true, Icons.circle),
        //     dayCard(7, 2, true, Icons.circle),
        //     dayCard(8, 2, true, Icons.circle),
        //     dayCard(9, 2, true, Icons.circle),
        //     dayCard(10, 2, true, Icons.circle),
        //   ],
        // ),