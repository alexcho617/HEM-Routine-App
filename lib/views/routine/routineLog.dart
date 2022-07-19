import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../widgets/widgets.dart';

class RoutineLogPage extends StatelessWidget {
  const RoutineLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(context, ListView(
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
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  'Day 5 (2022-06-27)',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            SizedBox(
              height: 33.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 21.w,
                  ),
                  SelectedRoutineButton(() {}, '전체'),
                  SizedBox(
                    width: 16.w,
                  ),
                  UnSelectedRoutineButton(() {}, '루틴 항목 이름 1'),
                  SizedBox(
                    width: 16.w,
                  ),
                  UnSelectedRoutineButton(() {}, '루틴 항목 이름 2'),
                  SizedBox(
                    width: 16.w,
                  ),
                  UnSelectedRoutineButton(() {}, '루틴 항목 이름 3'),
                  SizedBox(
                    width: 21.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            ListView.separated(
              itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              // physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => ListTile(
                // dense: true,
                // visualDensity: VisualDensity(vertical: 0),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                leading: CircleAvatar(
                  radius: 40.r,
                  backgroundColor: grey400,
                ),

                title: Text('루틴 항목 이름1'),
                subtitle: Text('오후 HH : MM'),
                trailing: Icon(Icons.delete),
              ),

              shrinkWrap: true,
              separatorBuilder: (context, index) => Container(
                  height: 24,
                  child: OverflowBox(
                    maxHeight: 40,
                    minHeight: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 48,),
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
