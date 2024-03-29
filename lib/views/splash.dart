import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'on_boarding.dart';

import '../controllers/login_service.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  LoginService service = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      centered: false,
      //그냥 container로 하면 알아서 center로 된다.
      splashIconSize: MediaQuery.of(context).size.height,
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "나만의 변비 관리 루틴 앱",
              style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "쾌변루틴",
              style: TextStyle(fontFamily: 'GmarketSans', fontSize: 36.sp),
            ),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: Image.asset('assets/appIcon.png'),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "LOADING...",
              style: TextStyle(fontFamily: 'AppleSDGothicNeo', fontSize: 16),
            ),
          ],
        ),
      ),
      nextScreen: FirebaseAuth.instance.currentUser == null
          ? const OnBoardingPage()
          : HomePage(),
    );
  }
}
