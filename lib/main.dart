import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/eventController.dart';
import 'package:hem_routine_app/controller/loginService.dart';
import 'package:hem_routine_app/firebase_options.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/routine/routineBuild.dart';
import 'package:hem_routine_app/views/routine/routineEntrySetting.dart';
import 'package:hem_routine_app/views/routine/routineLog.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/login.dart';
import 'package:hem_routine_app/views/onBoarding.dart';
import 'package:hem_routine_app/views/routine/routine.dart';
import 'package:hem_routine_app/views/setting/account_settings.dart';
import 'package:hem_routine_app/views/setting/settings.dart';
import 'package:hem_routine_app/views/splash.dart';
import 'package:hem_routine_app/views/test.dart';

import 'package:hem_routine_app/views/widgetTestPage.dart';
import 'controller/routineItemController.dart';
import 'views/setting/profile_settings.dart';

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
              primarySwatch: createMaterialColor(primary),
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
              '/bottomSheet' : (context) => RoutineLogPage(),
              '/routineBuild' : (context) => RoutineBuildPage(),
              '/settings' : (context) => SettingsPage(),
              '/accountSettings' : (context) => AccountSettingsPage(),
              '/routineEntrySetting' : (context) => RoutineEntrySettingPage(),
              '/profileSettings' : (context) => ProfileSettingsPage(),
              // '/test1' : (context) => MyStatefulWidget(),
            },
          );
        });
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;
 
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}