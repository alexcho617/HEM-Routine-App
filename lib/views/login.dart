import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
// import 'package:flutterfire_ui/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/controller/loginController.dart';
import 'package:hem_routine_app/services/service.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/widgetTestPage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static FirebaseAuth auth = FirebaseAuth.instance;
  AuthCredential? appleCredential = null;
  GoogleSignInAccount? googleCredential = null;
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    print("This is build function in login page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInWithAppleButton(
              onPressed: () async {
                //get apple credential
                appleCredential = await signInWithApple();
                //login with apple credential
                await auth.signInWithCredential(appleCredential!).then((value) {
                  if (auth.currentUser != null) {
                    Get.to(HomePage());
                    controller.uid.value = auth.currentUser!.uid;
                  } else {
                    Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
                  }
                });
              },
            ),
           
            GoogleSignInButton(
              clientId: '438160748395-iukm50ov2pqdatcp7o118njr4msg9fg5.apps.googleusercontent.com',
              onTap: () async {
                //get apple credential
                googleCredential = await GoogleSignIn(
                  scopes: [
                    'email',
                    'https://www.googleapis.com/auth/contacts.readonly',
                  ],
                ).signIn();

                final GoogleSignInAuthentication? googleAuth =
                    await googleCredential?.authentication;
                // print("auth_service.dart 38 : googleAuth assigned");

                // Create a new credential
                final credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth?.accessToken,
                  idToken: googleAuth?.idToken,
                );

                // Once signed in, return the UserCredential
                await auth.signInWithCredential(credential).then((value) {
                  if (auth.currentUser != null) {
                    Get.to(HomePage());
                    controller.uid.value = auth.currentUser!.uid;
                  } else {
                    Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
                  }
                });
              },
            ),
            TextButton(
              onPressed: () {
                Get.to(HomePage());
              },
              child: Text('bypass'),
            ),
            TextButton(
              onPressed: (() {
                Get.to(WidgetTestPage());
              }),
              child: Text('Widgets'),
            )
          ],
        ),
      ),
    );
  }
}
