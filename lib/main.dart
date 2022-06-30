import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/firebase_options.dart';
import 'package:hem_routine_app/views/home.dart';
import 'package:hem_routine_app/views/login.dart';
import 'package:hem_routine_app/views/splash.dart';
import 'package:hem_routine_app/views/widgetTestPage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(390,844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return GetMaterialApp(
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
          },
        );
      }
    );
  }
}
