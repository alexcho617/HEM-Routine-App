import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';
import 'package:hem_routine_app/controller/loginService.dart';
import 'package:hem_routine_app/firebase_options.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/login.dart';
import 'package:hem_routine_app/views/onBoarding.dart';
import 'package:hem_routine_app/views/routine/routine.dart';
import 'package:hem_routine_app/views/splash.dart';
import 'package:hem_routine_app/views/test.dart';

import 'package:hem_routine_app/views/widgetTestPage.dart';
import 'controller/routineItemController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initServices();
  runApp(const MyApp());
}

void initServices() {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  Get.put(LoginService());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RoutineItemController());
    Get.put(EventController());

    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/splash',
            routes: {
              '/home': (context) => HomePage(),
              '/splash': (context) => SplashScreen(),
              '/login': (context) => LoginPage(),
              '/widgetTest': (context) => WidgetTestPage(),
              '/onBoarding': (context) => onBoardingPage(),
              '/test' : (context) => App(),
              '/routine' : (context) => RoutinePage(),
              // '/test1' : (context) => MyStatefulWidget(),
            },
          );
        });
  }
}
