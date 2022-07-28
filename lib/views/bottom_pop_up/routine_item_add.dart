import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/routineBuildController.dart';

import 'package:hem_routine_app/main.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../widgets/widgets.dart';

class RoutineItemAddPage extends StatelessWidget {
  RoutineItemAddPage({Key? key}) : super(key: key);

  RoutineBuildController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return customBottomSheet(
        context,
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: 45.h,
            ),
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<RoutineBuildController>(
                  builder: (_) {
                    return Row(
                      children: _.categoryButtons,
                    );
                  }
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 27.h,
            ),
            Expanded(
              child: GetBuilder<RoutineBuildController>(builder: (_) {
                return ListView.builder(
                  itemCount: pageController.routineItems.length,
                  // physics: NeverScrollableScrollPhysics(),
                  // physics: const AlwaysScrollableScrollPhysics(),
                  // itemExtent: 95.h,
                  itemBuilder: (BuildContext context, int index) => 
                  (pageController.routineItems[index].category == pageController.categories[pageController.categoryIndex] || pageController.categoryIndex == 0)?
                  Container(
                    // height: 95.h,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        side:pageController.routineItems[index].isChecked? BorderSide(color: primary, width: 1) : BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onLongPress: () {
                          //1
                          pageController.tapState(true, index);
                        },
                        onLongPressUp: () {
                          pageController.tapState(false, index);
                        },
                        child: ListTile(
                          leading: Checkbox(
                            //2
                            side: BorderSide(color: Colors.black, width: 0.5),
                            value: pageController.routineItems[index].isChecked,
                            onChanged: (value) {
                              pageController.checkState(value!, index);
                            },
                          ),
                          title: pageController.routineItems[index].isTapped
                              ? Text(
                                  '${pageController.routineItems[index].name}',
                                  style: TextStyle(fontSize: 18.sp),
                                )
                              : Text(
                                  '${pageController.routineItems[index].name}',
                                  style: TextStyle(fontSize: 18.sp),
                                  overflow: TextOverflow.ellipsis,
                                ),
                          subtitle: pageController.routineItems[index].isTapped
                              ? Text(
                                  '${pageController.routineItems[index].description}',
                                )
                              : Text(
                                  '${pageController.routineItems[index].description}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '#${pageController.routineItems[index].category}',
                                style:
                                    TextStyle(fontSize: 12.sp, color: primary),
                              ),
                            ],
                          ),
                          
                        ),
                      ),
                    ),
                  )
                  :Container(
                   
                  ),

                  shrinkWrap: true,
                );
              }),
            ),
          ],
        ));
  }
}
