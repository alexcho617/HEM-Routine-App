import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/routineOffController.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../widgets/widgets.dart';

class RoutineItemAddPage extends StatelessWidget {
  RoutineItemAddPage({Key? key}) : super(key: key);

  RoutineOffController pageController = Get.find();
  

  @override
  Widget build(BuildContext context) {
    return customBottomSheet(
        context,
        Stack(
          children: [
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
                    child: GetBuilder<RoutineOffController>(builder: (_) {
                      return Row(
                        children: _.categoryButtons,
                      );
                    }),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 27.h,
                ),
                Expanded(
                  child: GetBuilder<RoutineOffController>(builder: (_) {
                    return ListView.builder(
                      itemCount: pageController.routineItems.length,
                      // physics: NeverScrollableScrollPhysics(),
                      // physics: const AlwaysScrollableScrollPhysics(),
                      // itemExtent: 95.h,
                      itemBuilder: (BuildContext context, int index) =>
                          (pageController.routineItems[index].category ==
                                      pageController.categories[
                                          pageController.categoryIndex] ||
                                  pageController.categoryIndex == 0)
                              ? GestureDetector(
                                  onTap: () {
                                    if (pageController
                                        .routineItems[index].isChecked) {
                                      pageController
                                          .decreaseSelectedRoutineCount();
                                    } else {
                                      pageController
                                          .increaseSelectedRoutineCount();
                                    }
                                    pageController.checkState(
                                        !pageController
                                            .routineItems[index].isChecked,
                                        index);
                                  },
                                  onLongPress: () {
                                    //1
                                    pageController.tapState(true, index);
                                  },
                                  onLongPressUp: () {
                                    pageController.tapState(false, index);
                                  },
                                  child: Container(
                                    // height: 95.h,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 16),
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        side: pageController
                                                .routineItems[index].isChecked
                                            ? BorderSide(
                                                color: primary, width: 1)
                                            : BorderSide(
                                                color: Colors.transparent,
                                                width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        leading: Checkbox(
                                          //2
                                          side: BorderSide(
                                              color: Colors.black, width: 0.5),
                                          value: pageController
                                              .routineItems[index].isChecked,
                                          onChanged: (value) {
                                            if (pageController
                                                .routineItems[index]
                                                .isChecked) {
                                              pageController
                                                  .decreaseSelectedRoutineCount();
                                            } else {
                                              pageController
                                                  .increaseSelectedRoutineCount();
                                            }
                                            pageController.checkState(
                                                !pageController
                                                    .routineItems[index]
                                                    .isChecked,
                                                index);
                                          },
                                        ),
                                        title: pageController
                                                .routineItems[index].isTapped
                                            ? Text(
                                                '${pageController.routineItems[index].name}',
                                                style:
                                                    TextStyle(fontSize: 18.sp),
                                              )
                                            : Text(
                                                '${pageController.routineItems[index].name}',
                                                style:
                                                    TextStyle(fontSize: 18.sp),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        subtitle: pageController
                                                .routineItems[index].isTapped
                                            ? Text(
                                                '${pageController.routineItems[index].description}',
                                              )
                                            : Text(
                                                '${pageController.routineItems[index].description}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '#${pageController.routineItems[index].category}',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),

                      shrinkWrap: true,
                    );
                  }),
                ),
              ],
            ),
            GetBuilder<RoutineOffController>(builder: (_) {
              return Positioned(
                  bottom: 126.h,
                  right: 95.w,
                  child:
                      routineAdd(pageController.selectedRoutineItemCount, context));
            })
          ],
        ));
  }
}

Widget routineAdd(int number, context) {
  return Container(
    width: 200.w,
    height: 48.h,
    child: ElevatedButton(
      onPressed: () {
        if (number - 30 > 0) {
          showDialog(
              context: context,
              builder: ((context) {
                return overNumAlertDialog(() {
                  Navigator.pop(context);
                }, number - 30);
              }));
        } else {
          //data transforming
          
          Navigator.pop(context);
        }
      },
      child: Text(
        '$number건의 루틴 항목 추가',
        style: AppleFont14_White,
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    ),
  );
}

Widget overNumAlertDialog(VoidCallback? onPressed, int over) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(20.r),
    )),
    insetPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: Container(
      width: 312.w,
      height: 176.h,
      child: Column(children: [
        Container(
          width: 312.w,
          height: 120.h,
          child: Center(
              child: Text(
            '루틴 항목은 최대 30개 까지\n추가할 수 있습니다. ($over건 초과).',
            style: AppleFont16_Black,
            textAlign: TextAlign.center,
          )),
        ),
        InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
              color: primary,
            ),
            width: 312.w,
            height: 56.h,
            child: Center(
              child: Text(
                '확인',
                style: AppleFont16_White,
              ),
            ),
          ),
        )
      ]),
    ),
  );
}
