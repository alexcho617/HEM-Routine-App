// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/login_service.dart';
import 'controllers/app_state_controller.dart';
import 'firebase_options.dart';
import 'utils/colors.dart';
import 'views/routine/routine_build.dart';
import 'views/routine/routine_entity_setting.dart';
import 'views/bottom_pop_up/routine_log.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/on_boarding.dart';
import 'views/routine/routine.dart';
import 'views/setting/account_settings.dart';
import 'views/setting/settings.dart';
import 'views/splash.dart';
import 'views/widget_test_page.dart';
import 'views/setting/completed_routines.dart';
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
  // print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  Get.put(LoginService());
  Get.put(AppStateController());
  // print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              '/onBoarding': (context) => OnBoardingPage(),
              '/routine': (context) => RoutinePage(),
              '/bottomSheet': (context) => RoutineLogPage(),
              '/routineBuild': (context) => RoutineBuildPage(),
              '/settings': (context) => SettingsPage(),
              '/accountSettings': (context) => AccountSettingsPage(),
              '/routineEntrySetting': (context) => RoutineEntitySettingPage(),
              '/profileSettings': (context) => ProfileSettingsPage(),
              '/completedRoutines': (context) => CompletedRoutinesPage(),
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
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
