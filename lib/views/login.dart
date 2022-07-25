import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
// import 'package:flutterfire_ui/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/controller/loginService.dart';

import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/widgetTestPage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  
  
  GoogleSignInAccount? googleCredential = null;
  LoginService service = Get.find();

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
                await service.signInWithApple();
              },
            ),
            GoogleSignInButton(
              clientId:
                  '438160748395-iukm50ov2pqdatcp7o118njr4msg9fg5.apps.googleusercontent.com',
              onTap: () async {
                //get apple credential
                await service.signInwithGoogle();
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
            ),
            Text('${service.auth.value.currentUser}')
          ],
        ),
      ),
    );
  }
}
