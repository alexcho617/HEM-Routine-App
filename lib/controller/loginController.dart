import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class LoginController extends GetxController {
  AuthCredential? appleCredential;
  GoogleSignInAccount? googleCredential;
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  var uid = ''.obs;
  var name = ''.obs;

  Future<void> signInwithGoogle() async {
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
    await auth.value.signInWithCredential(credential).then((value) {
      if (auth.value.currentUser != null) {
        Get.to(HomePage());
        uid.value = auth.value.currentUser!.uid;
      } else {
        Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
      }
    });
  }

  Future<void> signInWithApple() async {
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

    await auth.value.signInWithCredential(oauthCredential).then((value) {
      if (auth.value.currentUser != null) {
        Get.to(HomePage());
        uid.value = auth.value.currentUser!.uid;
      } else {
        Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
      }
    });
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
}
