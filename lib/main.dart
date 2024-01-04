import 'package:hive_flutter/hive_flutter.dart';
import 'package:timegaurdian/UI/splash_screen.dart';
import 'package:timegaurdian/UI/walkthrough.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:timegaurdian/UI/pomodoro/timerservice.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // remove debug banner
  // debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  );


   runApp(ChangeNotifierProvider<timerservice>(
      create: (_) => timerservice(),
      child: MyApp(),
    ));

  // runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//       FlutterNativeSplash.remove();
//     return MaterialApp(
//         title: 'Contracto App',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/splash',
//         // initialRoute: AppSplashScreen.tag,

//         routes: {
//           //New UI
//           '/splash': (context) => const SplashScreen(),

//         },
//     );
//   }
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      maximumSize: Size(450.0, 900.0),
      enabled: kIsWeb,
      builder: (context) {
        FlutterNativeSplash.remove();
        return MaterialApp(
          title: 'Time Gaurdian',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),

          // initialRoute: '/splash',
          // // initialRoute: AppSplashScreen.tag,

          // routes: {
          //   //New UI
          //   '/splash': (context) => SplashScreen(),

          // },
        );
      },
    );
  }
}

