import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/custom_routine_item_contoller.dart';
import 'package:hem_routine_app/controllers/routine_item_setting_controller.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/functions.dart';
import 'package:hem_routine_app/views/setting/custom_routine_item.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class RoutineItemSettingsPage extends StatelessWidget {
  RoutineItemSettingsPage({Key? key}) : super(key: key);
  RotuineItemSettingController pageController =
      Get.put(RotuineItemSettingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RotuineItemSettingController>(builder: (context) {
      return Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              customAppBar(context, '루틴 항목 관리'),
              pageController.customRoutineItems.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 170.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 115.w),
                          child: Image.asset('assets/appIcon.png'),
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        Text(
                          '등록된 루틴항목이 없습니다.',
                          style: AppleFont16_Black,
                        ),
                      ],
                    )
                  : Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 23.h,
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.all(20.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton(
                                  elevation: 10,
                                  onSelected: (value) {
                                    pageController.filter.value =
                                        value.toString();
                                    pageController.update();
                                  },
                                  shape: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  itemBuilder: (context) {
                                    return pageController.categories
                                        .map((category) {
                                      return PopupMenuItem(
                                        height: 32.h,
                                        child: Text(
                                          category,
                                          style: AppleFont14_Grey600,
                                        ),
                                        value: category,
                                      );
                                    }).toList();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.filter_alt,
                                        size: 18.r,
                                        color: grey600,
                                      ),
                                      Text(
                                        " ${pageController.filter.value}",
                                        style: AppleFont14_Grey600,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Expanded(
                        GetBuilder<RotuineItemSettingController>(
                            // id: 1,
                            builder: (_) {
                          return ListView.builder(
                            itemCount: pageController.customRoutineItems.length,
                            // physics: NeverScrollableScrollPhysics(),
                            // physics: const AlwaysScrollableScrollPhysics(),
                            // itemExtent: 95.h,
                            itemBuilder: (BuildContext context, int index) {
                              return index ==
                                      pageController.customRoutineItems.length -
                                          1
                                  ? Column(
                                      children: [
                                        routineItem(index, context),
                                        Container(
                                          width: 348.w,
                                          height: 56.h,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              kangminToCustomRoutineItem(
                                                  ScreenArguments(
                                                      CRUD.create,
                                                      FromWhere
                                                          .routineItemSetting,
                                                      null),
                                                  context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: grey600,
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Text(
                                                  '나만의 루틴 항목 만들기',
                                                  style: AppleFont14_Grey600,
                                                ),
                                              ],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shadowColor: Colors.transparent,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: grey600, width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : routineItem(index, context);
                            },

                            shrinkWrap: true,
                          );
                        }),
                        // ),
                      ],
                    ),
            ],
          ));
    });
  }

  Widget routineItem(int index, context) {
    //여기서 visibility를 검사하자.
    if (pageController.filter.value == '전체' || pageController.filter.value ==
        pageController.customRoutineItems[index].category) {
      return GestureDetector(
        onTap: () {
          kangminToCustomRoutineItem(
              ScreenArguments(CRUD.update, FromWhere.routineItemSetting,
                  pageController.customRoutineItems[index]),
              context);
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              side: pageController.customRoutineItems[index].isChecked
                  ? BorderSide(color: primary, width: 1)
                  : BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: pageController.customRoutineItems[index].isTapped
                  ? Text(
                      '${pageController.customRoutineItems[index].name}',
                      style: TextStyle(fontSize: 18.sp),
                    )
                  : Text(
                      '${pageController.customRoutineItems[index].name}',
                      style: TextStyle(fontSize: 18.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
              subtitle: pageController.customRoutineItems[index].isTapped
                  ? Text(
                      '${pageController.customRoutineItems[index].description}',
                    )
                  : Text(
                      '${pageController.customRoutineItems[index].description}',
                      overflow: TextOverflow.ellipsis,
                    ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '#${pageController.customRoutineItems[index].category}',
                    style: TextStyle(fontSize: 12.sp, color: primary),
                  ),
                  pageController.customRoutineItems[index].isCustom
                      ? Container(
                          height: 41.h,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.settings_outlined)))
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      );
    }
    else{
      return const SizedBox.shrink();
    }
  }
}
