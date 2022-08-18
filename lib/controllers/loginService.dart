import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService extends GetxController {
  AuthCredential? appleCredential;
  GoogleSignInAccount? googleCredential;
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;

  CollectionReference users = FirebaseFirestore.instance.collection('user');

  var uid = ''.obs;
  var name = ''.obs;
  late DocumentSnapshot userSnapshot;

  @override
  void onInit() async {
    await getSnapshot();
    if (userSnapshot.exists) {
      uid.value = userSnapshot.id;
      name.value = userSnapshot.get('name');
    }
    super.onInit();
  }

  Future<void> getSnapshot() async {
    userSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.value.currentUser!.uid)
        .get();
  }

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
        name.value = auth.value.currentUser!.displayName!;
      } else {
        Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
      }
    });

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.value.currentUser!.uid)
        .get();
    if (userSnapshot == null || !userSnapshot.exists) {
      addUserDocument();
    }

    Get.find<AppStateController>().isRoutineActive();
  }

  Future<void> signOut() async {
    auth.value.signOut();
  }

  Future<void> addUserDocument() {
    return users
        .doc(auth.value.currentUser!.uid)
        .set({
          'name': auth.value.currentUser!.displayName,
        })
        .then((value) => print("User Document Created"))
        .catchError((error) => print("Faied to Add User document: ${error}"));
  }

  Future<void> profileSetting(
      String newName, DateTime birthDate, String gender) {
    name.value = newName;
    return users
        .doc(auth.value.currentUser!.uid)
        .set({
          'name': newName,
          'birthDate': birthDate,
          'gender': gender,
        })
        .then((value) => print("User Document Created"))
        .catchError((error) => print("Faied to Add User document: ${error}"));
  }

  Future<void> deleteUser() {
    return users
        .doc(auth.value.currentUser!.uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
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
