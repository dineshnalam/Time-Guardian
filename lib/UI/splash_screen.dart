import 'dart:async';
import 'package:timegaurdian/UI/common/main_login.dart';
import 'package:timegaurdian/UI/dashboard.dart';
import 'package:timegaurdian/UI/homepage.dart';
import 'package:timegaurdian/UI/walkthrough.dart';
import 'package:timegaurdian/services/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:prokit_flutter/main/screens/ProKitLauncher.dart';

 
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  bool _a = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;
  bool secondAnim = false;

  Color boxColor = Colors.transparent;
  Color circleColor = Color(0xFFD7DBDD);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        boxColor = context.iconColor;
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        boxColor = context.scaffoldBackgroundColor;
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3200), () {
      secondAnim = true;

      scaleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      )..forward();
      scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController!);

      setState(() {
        boxColor = context.scaffoldBackgroundColor;
        _d = true;
      });
    });

    Timer(const Duration(milliseconds: 4200), () async {
      secondAnim = true;
      setState(() {});
      if(FirebaseAuth.instance.currentUser == null){
      LoginScreen().launch(context, isNewTask: true, );
      }else{
        String? uid = FirebaseAuth.instance.currentUser?.uid;
        final userSnpashot = await usersRef.doc(uid).get();

        if (userSnpashot.exists) {
          //Existing User
          Fluttertoast.showToast(msg: "Existing User");
          ContractorHomePage().launch(context);
        } else {
          Fluttertoast.showToast(msg: "Error");
          LoginScreen().launch(context, isNewTask: true, );
        }
      }
    });
    afterBuildCreated(() async {
      // setValue(appOpenCount, (getIntAsync(appOpenCount)) + 1);
      // await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage), context: context);
    });
  }

  @override
  void dispose() {
    scaleController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double _h = context.height();
    double _w = context.width();

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _h / (kIsWeb ? 2.5 : 4.5)
                      : 20,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(seconds: _c ? 2 : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                      ? 130
                      : 20,
              width: _d
                  ? _w
                  : _c
                      ? 130
                      : 20,
              decoration: BoxDecoration(
                  color: boxColor,
                  //shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d ? BorderRadius.only() : BorderRadius.circular(30)),
              child: secondAnim
                  ? Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        //decoration: BoxDecoration(color: appStore.isDarkModeOn ? context.cardColor : appSplashSecondaryColor, shape: BoxShape.circle),
                        decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation!,
                          builder: (c, child) => Transform.scale(
                            scale: scaleAnimation!.value,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: appStore.isDarkModeOn ? context.cardColor : appSplashSecondaryColor,
                                color: circleColor,

                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: _e ? Image.asset('assets/icon_trans.png', height: 130, width: 130, fit: BoxFit.cover) : SizedBox(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
