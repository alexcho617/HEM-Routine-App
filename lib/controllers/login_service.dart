// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/controllers/calendar_controller.dart';
import 'package:hem_routine_app/controllers/report_controller.dart';
import 'package:hem_routine_app/controllers/routine_completed_controller.dart';
import 'package:hem_routine_app/controllers/routine_item_setting_controller.dart';
import 'package:hem_routine_app/controllers/routine_off_controller.dart';
import 'package:hem_routine_app/controllers/routine_on_controller.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoginStatus { ready, progress, done, fail }

class LoginService extends GetxController {
  AuthCredential? appleCredential;
  GoogleSignInAccount? googleCredential;
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  AuthCredential? authCredential;
  var loginStatus = LoginStatus.ready.obs;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  var uid = ''.obs;
  var name = ''.obs;
  var gender = '';
  var birthDay = DateTime.now();
  late DocumentSnapshot userSnapshot;

  @override
  void onInit() async {
    if (auth.value.currentUser != null) {
      userSnapshot = await getSnapshot();
      //register a token
      setupToken();
      if (userSnapshot.exists) {
        uid.value = userSnapshot.id;
        name.value = userSnapshot.get('name');
      }
    }
    super.onInit();
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('user').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> authStateListner() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
  }

  Future<DocumentSnapshot> getSnapshot() async {
    return userSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.value.currentUser!.uid)
        .get();
  }

  Future<void> signInwithGoogle() async {
    try {
      googleCredential = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleCredential?.authentication;

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
          authCredential = credential;
        } else {
          Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
          loginStatus.value = LoginStatus.fail;
        }
      });

      await dataRefreshSequence().then((value) {
        loginStatus.value = LoginStatus.done;
        update();
      });
    } catch (e) {
      print(e);
      loginStatus.value = LoginStatus.fail;
    }
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
        authCredential = oauthCredential;
      } else {
        Get.snackbar('로그인 실패', '로그인에 실패하였습니다.');
        loginStatus.value = LoginStatus.fail;
      }
    });
    await dataRefreshSequence().then((value) {
      loginStatus.value = LoginStatus.done;
      update();
    });
  }

  Future<void> dataRefreshSequence() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(auth.value.currentUser!.uid)
        .get();
    if (!userSnapshot.exists) {
      addUserDocument();
    }
    Get.put(RoutineCompletedController());

    Get.find<AppStateController>().uid = auth.value.currentUser!.uid;
    Get.find<AppStateController>().isRoutineActive();
    Get.find<CalendarController>().getAllData();
    Get.find<ReportController>().refreshData();
    Get.find<RoutineOnController>().getAllData();
    Get.find<RoutineOffController>().getAllData();
    Get.find<RoutineCompletedController>().getLatestData();
    Get.find<AppStateController>().isUserHaveRated(auth.value.currentUser!.uid);
  }

  Future<void> signOut() async {
    await auth.value.signOut();
    // if (auth.value.currentUser != null) {
    //   auth.value.currentUser!.delete();
    // }

    // if (auth.value.currentUser == null) {
    //   print('current user null');
    // } else {
    //   print('currentUser not null');
    // }
    Get.put(RoutineCompletedController());
    Get.find<CalendarController>().clearAllData();
    //clear routine
    Get.find<RoutineOnController>().clearAllData();
    Get.find<RoutineOffController>().clearAllData();
    Get.find<RoutineCompletedController>().clearAllData();
    //clear report
    Get.find<ReportController>().clearAllData();
  }

  Future<void> addUserDocument() {
    return users.doc(auth.value.currentUser!.uid).set({
      'name': auth.value.currentUser!.displayName,
      'isRated': true,
      'rateRoutineId': "",
      'rateRoutineHistoryId': "",
      'pushPermission': true,
    }).then((value) {
      if (kDebugMode) {
        print("User Document Created");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Faied to Add User document: $error");
      }
    });
  }

  Future<bool> getProfile() async {
    late bool _b;
    await users
        .doc(auth.value.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name.value = documentSnapshot.get('name');
      birthDay = documentSnapshot.get('birthDate').toDate();
      gender = documentSnapshot.get('gender');
      _b = true;
    });
    return _b;
  }

  Future<DateTime> getBirthDay() async {
    return birthDay;
  }

  Future<void> profileSetting(
      String newName, DateTime birthDate, String gender) {
    name.value = newName;
    return users.doc(auth.value.currentUser!.uid).update({
      'name': newName,
      'birthDate': birthDate,
      'gender': gender,
    }).then((value) {
      if (kDebugMode) {
        print("User Document Created");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Faied to Add User document: $error");
      }
    });
  }

  Future<void> firestoreUserDelete() async {
    await users.doc(auth.value.currentUser!.uid).delete();
  }

  Future<void> dataDelete() async {
    RoutineCompletedController _routineCompletedController =
        Get.put(RoutineCompletedController());
    RotuineItemSettingController _routineItemSettingController =
        Get.put(RotuineItemSettingController());

    //delete Events
    await users
        .doc(auth.value.currentUser!.uid)
        .collection('Events')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to delete Events: $error");
      }
    });
    //delete calendarRoutine
    await users
        .doc(auth.value.currentUser!.uid)
        .collection('calendarRoutine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to delete calendarRoutine: $error");
      }
    });
    //delete routine
    await users
        .doc(auth.value.currentUser!.uid)
        .collection('routine')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to delete routine: $error");
      }
    });
    //delete userRoutineItems
    await users
        .doc(auth.value.currentUser!.uid)
        .collection('userRoutineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to delete routine: $error");
      }
    });

//
    Get.find<AppStateController>().status.value = false;
    Get.find<CalendarController>().clearAllData();
    //clear routine
    Get.find<RoutineOnController>().clearAllData();
    Get.find<RoutineOffController>().clearAllData();
    Get.find<RoutineCompletedController>().clearAllData();
    //clear report
    Get.find<ReportController>().clearAllData();
//

    Get.find<CalendarController>().getAllData();
    Get.find<RoutineOnController>().getAllData();
    Get.find<RoutineOffController>().getAllData();
    Get.find<ReportController>().refreshData();
    _routineCompletedController.getLatestData();
    _routineItemSettingController.getCustomRoutineItemNameList();
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

  // Future<void> deleteUser() async {
  //   try {
  //     await auth.value.currentUser!.reauthenticateWithCredential(authCredential!);
  //     await auth.value.currentUser!.delete();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'requires-recent-login') {
  //       print(
  //           'The user must reauthenticate before this operation can be executed.');
  //     }
  //   }
  // }
}
