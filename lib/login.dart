import 'package:flutter/material.dart';
import 'package:hem_routine_app/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'getxController/loginController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static FirebaseAuth auth = FirebaseAuth.instance;

  AuthCredential? appleCredential = null;
  loginController controller = Get.put(loginController());

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
                    print("auth current user is null");
                  }
                });
              },
            ),
            TextButton(
              onPressed: () {
                Get.to(HomePage());
              },
              child: Text('bypass'),
            )
          ],
        ),
      ),
    );
  }
}

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<OAuthCredential> signInWithApple() async {
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: appleCredential.authorizationCode);

  return oauthCredential;
}
