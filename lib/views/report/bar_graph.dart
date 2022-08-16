import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/utils/constants.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({Key? key}) : super(key: key);

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  SizedBox gap = SizedBox(
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 350,
      color: primary,
      child: Row(children: [
        Column(
          children: [
            Text('00시',style: AppleFont12_Black,),
            gap,
            Text('06시',style: AppleFont12_Black,),
            gap,
            Text('12시',style: AppleFont12_Black,),
            gap,
            Text('18시',style: AppleFont12_Black,),
            gap,
            Text('24시',style: AppleFont12_Black,),
          ],
        )
      ]),
    );
  }
}
