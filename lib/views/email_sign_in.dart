import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hem_routine_app/utils/constants.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  State<EmailSignInPage> createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
              footerBuilder: ((context, action) {
                return Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(style: AppleFont14_Grey600, text: '회원가입을 하시면 본'),
                      TextSpan(
                          style: AppleFont14_Blue600,
                          text: ' 약관 ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var url = Uri.parse('https://trite-drive-686.notion.site/HEM-43e9bdebaee0423b92f960ebd747afde');
                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            }),
                      TextSpan(
                          style: AppleFont14_Grey600,
                          text: '에 따라 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주합니다.'),
                    ]),
                    // 'By signing in, you agree to the ' + '',
                    // style: AppleFont14_Grey700,
                  ),
                );
              }),
              providerConfigs: [
                EmailProviderConfiguration(),
              ]);
        }
        // Render your application if authenticated
        return HomePage();
      },
    );
  }
}
