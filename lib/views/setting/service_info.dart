import 'package:flutter/material.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class ServiceInfoPage extends StatefulWidget {
  const ServiceInfoPage({Key? key}) : super(key: key);

  @override
  State<ServiceInfoPage> createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState extends State<ServiceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppBar(context, '서비스 안내'),
        ListTile(
          title: Text(
            '서비스 이용약관',
            style: AppleFont22_Black,
          ),
          onTap: () {
            //
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        ListTile(
          title: Text(
            '개인 정보 처리 방침',
            style: AppleFont22_Black,
          ),
          onTap: () {
            //
          },
          shape: Border(bottom: BorderSide(width: 0.8.w, color: grey500)),
        ),
        Container(
          width: 390.w,
          height: 526.h,
          color: Colors.grey[50],
          child: Padding(
            padding: EdgeInsets.all(28.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bigText("상호"),
                smallText("회사명"),
                bigText("대표"),
                smallText("홍길동"),
                bigText("주소"),
                smallText("경북 포항시 북구 흥해읍 한동로 558\n한동대학교 창업 보육센터 000호"),
                bigText("홈페이지"),
                smallText("www.example.com"),
                bigText("사업자등록번호"),
                smallText("000-00-00000"),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget bigText(String string) {
    return Padding(
      padding: EdgeInsets.all(4.r),
      child: Text(
        string,
        style: AppleFont16_BlackBold,
      ),
    );
  }
  Widget smallText(String string) {
    return Padding(
      padding: EdgeInsets.all(4.r),
      child: Text(
        string,
        style: AppleFont16_Black,
      ),
    );
  }
}
