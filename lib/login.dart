import 'package:flutter/material.dart';
import 'package:hem_routine_app/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCredential? appleCredential = null;
  @override
  Widget build(BuildContext context) {
    print("This is build function in login page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          children: [
            SignInWithAppleButton(
              onPressed: () async {
                //get apple credential
                appleCredential = await signInWithApple();
                if (appleCredential != null) {
                  print("auth credential not null");
                } else {
                  print("auth credential null");
                }
                //login with apple credential
                await _auth
                    .signInWithCredential(appleCredential!)
                    .then((value) {
                  if (_auth.currentUser != null) {
                    print("auth.currentuser not null");
                    Get.to(HomePage());
                    print(_auth.currentUser!.displayName);
                  } else {
                    print("auth current user is null");
                  }
                });

              },
            ),
            TextButton(
              onPressed: () {
                if (appleCredential == null) {
                  print('apple credential null');
                } else {
                  print(appleCredential);
                }
                if (_auth.currentUser == null) {
                  print('auth user null');
                } else {
                  print(_auth.currentUser.hashCode);
                  print(_auth.currentUser!.displayName);
                }
              },
              child: Text('stat'),
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
