import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineDetailPage extends StatelessWidget {
  const RoutineDetailPage({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('루틴 상세보기'),
            actions: [
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          SizedBox(
            height: 44.h,
          ),
          Text("루틴 이름 $index"),
        ],
      ),
    );
  }

  void onPressed() {
    //
  }
}
