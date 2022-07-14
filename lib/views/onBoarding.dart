import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/controller/loginController.dart';
import 'package:hem_routine_app/views/login.dart';
import 'package:hem_routine_app/widgets/widgets.dart';
import 'package:onboarding/onboarding.dart';

import '../utils/colors.dart';
import 'home.dart';

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({Key? key}) : super(key: key);

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  LoginController controller = Get.put(LoginController());
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "때마다 찾아오는\n변비\n어떻게 관리하세요?",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "심플하게\n배변을\n기록해보세요!",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "나에게 맞는\n쾌변 루틴을\n만들어 보세요!",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "배변 습관\n분석 리포트로\n매일 관리해보세요!",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {},
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 110.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < pagesLength; i++)
                          if (i == index) customBar(true) else customBar(false),
                      ],
                    ),
                    // index == pagesLength - 1
                    //     ? _signupButton
                    //     : _skipButton(setIndex: setIndex),
                  ],
                ),
              ),
              if (index == 0)
                nextButtonBig(() {
                  if (setIndex != null) {
                    index = 1;
                    setIndex(1);
                  }
                })
              else if (index == pagesLength - 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  child: GoogleSignInButton(
                    clientId:
                        '438160748395-iukm50ov2pqdatcp7o118njr4msg9fg5.apps.googleusercontent.com',
                    onTap: () async {
                      //get apple credential
                      controller.signInwithGoogle();
                    },
                  ),
                )
              else
                nextAndBackButton(() {
                  if (setIndex != null) {
                    setIndex(--index);
                  }
                }, () {
                  if (setIndex != null) {
                    setIndex(++index);
                  }
                }),
              SizedBox(
                height: 89.h,
              )
            ]);
          },
        ),
      ),
    );
  }
}

Widget customBar(bool isActive) {
  return AnimatedContainer(
    alignment: Alignment.center,
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 8.w),
    height: 8.h,
    width: isActive ? 24.w : 16.w,
    decoration: BoxDecoration(
        color: isActive ? primary : grey500,
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );
}
