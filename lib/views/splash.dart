// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("나만의 변비 관리 루틴 앱",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16),),
//               SizedBox(height: 16,),
//               Text("쾌변루틴",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 36),),
//               SizedBox(height: 250,),
//               Text("LOADING...",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16),),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hem_routine_app/views/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        centered: false,
        // duration: 500000,
        //그냥 container로 하면 알아서 center로 된다.
        splashIconSize: MediaQuery.of(context).size.height,
        splash: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("나만의 변비 관리 루틴 앱",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16),),
                SizedBox(height: 16,),
                Text("쾌변루틴",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 36),),
                SizedBox(height: 250,),
                Text("LOADING...",style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16),),
              ],
            ),
          ),
        ),
        nextScreen: HomePage(),
    );
  }
}