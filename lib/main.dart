// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controllers/calendarController.dart';
import 'package:hem_routine_app/controllers/loginService.dart';
import 'package:hem_routine_app/controllers/app_state_controller.dart';
import 'package:hem_routine_app/firebase_options.dart';
import 'package:hem_routine_app/utils/colors.dart';
import 'package:hem_routine_app/views/routine/routineBuild.dart';
import 'package:hem_routine_app/views/routine/routineEntitySetting.dart';
import 'package:hem_routine_app/views/bottom_pop_up/routineLog.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/login.dart';
import 'package:hem_routine_app/views/onBoarding.dart';
import 'package:hem_routine_app/views/routine/routine.dart';
import 'package:hem_routine_app/views/setting/account_settings.dart';
import 'package:hem_routine_app/views/setting/custom_routine_item.dart';
import 'package:hem_routine_app/views/setting/settings.dart';
import 'package:hem_routine_app/views/splash.dart';
import 'package:hem_routine_app/views/test.dart';

import 'package:hem_routine_app/views/widgetTestPage.dart';
import 'controllers/routine_completed_controller.dart.dart';
import 'controllers/routine_on_controller.dart';
import 'views/setting/completed_routines.dart';
import 'views/setting/profile_settings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    Get.put(AppStateController());
    Get.put(CalendarController());
    Get.put(RoutineOnController());

    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return GetMaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: createMaterialColor(primary),
            ),
            initialRoute:
                '/splash', //use home for development, spalsh for deployment
            routes: {
              '/home': (context) => HomePage(),
              '/splash': (context) => SplashScreen(),
              '/login': (context) => LoginPage(),
              '/widgetTest': (context) => WidgetTestPage(),
              '/onBoarding': (context) => onBoardingPage(),
              '/test': (context) => App(),
              '/routine': (context) => RoutinePage(),
              '/bottomSheet': (context) => RoutineLogPage(),
              '/routineBuild': (context) => RoutineBuildPage(),
              '/settings': (context) => SettingsPage(),
              '/accountSettings': (context) => AccountSettingsPage(),
              '/routineEntrySetting': (context) => RoutineEntitySettingPage(),
              '/profileSettings': (context) => ProfileSettingsPage(),
              '/completedRoutines': (context) => CompletedRoutinesPage(),
              

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
