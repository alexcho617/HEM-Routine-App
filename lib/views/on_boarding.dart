import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/views/email_sign_in.dart';
import 'package:onboarding/onboarding.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_service.dart';
import '../widgets/widgets.dart';

import '../utils/colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final LoginService _loginService = Get.find();
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
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 63.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "때마다 찾아오는\n변비\n어떻게 관리하세요?",
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
            ),
            Image.asset(
              'assets/onboarding/1.png',
              height: 200.h,
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
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 63.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "심플하게\n배변을\n기록해보세요!",
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
            ),
            Image.asset(
              'assets/onboarding/2.png',
              height: 200.h,
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
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 63.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "나에게 맞는\n쾌변 루틴을\n만들어 보세요!",
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
            ),
            Image.asset(
              'assets/onboarding/3.png',
              height: 200.h,
            ),
            // Expanded(child: Container()),
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
              padding: EdgeInsets.fromLTRB(31.w, 139.h, 0, 63.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "배변 습관\n분석 리포트로\n매일 관리해보세요!",
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
            ),
            Image.asset(
              'assets/onboarding/4.png',
              height: 150.h,
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

  // Material get _signupButton {
  //   return Material(
  //     borderRadius: defaultProceedButtonBorderRadius,
  //     color: defaultProceedButtonColor,
  //     child: InkWell(
  //       borderRadius: defaultProceedButtonBorderRadius,
  //       onTap: () {},
  //       child: const Padding(
  //         padding: defaultProceedButtonPadding,
  //         child: Text(
  //           'Sign up',
  //           style: defaultProceedButtonTextStyle,
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                padding: EdgeInsets.only(bottom: 10.h),
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
                  index = 1;
                  setIndex(1);
                })
              else if (index == pagesLength - 1)
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31.w),
                    child: _loginService.loginStatus.value ==
                            LoginStatus.progress
                        ? SizedBox(
                            height: 80.r,
                            width: 80.r,
                            child: CircularProgressIndicator(
                              color: primary,
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                GoogleSignInButton(
                                  clientId:
                                      '438160748395-iukm50ov2pqdatcp7o118njr4msg9fg5.apps.googleusercontent.com',
                                  onTap: () async {
                                    setState(() {
                                      _loginService.loginStatus.value =
                                          LoginStatus.progress;
                                    });
                                    //get apple credential
                                    _loginService.signInwithGoogle();
                                  },
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Platform.isIOS
                                    ? SignInWithAppleButton(onPressed: () {
                                        setState(() {
                                          _loginService.loginStatus.value =
                                              LoginStatus.progress;
                                        });
                                        _loginService.signInWithApple();
                                      })
                                    : const SizedBox.shrink(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        style: AppleFont14_Grey600,
                                        text: '회원가입을 하시면 본'),
                                    TextSpan(
                                        style: AppleFont14_Blue600,
                                        text: ' 약관 ',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            var url = Uri.parse(
                                                'https://trite-drive-686.notion.site/HEM-43e9bdebaee0423b92f960ebd747afde');
                                            if (!await launchUrl(url)) {
                                              throw 'Could not launch $url';
                                            }
                                          }),
                                    TextSpan(
                                        style: AppleFont14_Grey600,
                                        text:
                                            '에 따라 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주합니다.'),
                                  ]),
                                  // 'By signing in, you agree to the ' + '',
                                  // style: AppleFont14_Grey700,
                                ),
                              ],
                            ),
                          ),
                  );
                })
              else
                nextAndBackButton(() {
                  setIndex(--index);
                }, () {
                  setIndex(++index);
                }),
              SizedBox(
                height: 80.h,
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
    duration: const Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 8.w),
    height: 8.h,
    width: isActive ? 24.w : 16.w,
    decoration: BoxDecoration(
        color: isActive ? primary : grey500,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
  );
}
