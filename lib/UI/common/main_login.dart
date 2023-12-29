import 'package:timegaurdian/UI/common/verification.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?
    Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: WAPrimaryColor,
          size: 60,
        ),
      ),
    )
    : Scaffold(
      body: Container(
        width: context.width(),
        height: context.height(),
        
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              50.height,
              Text("Log In", style: boldTextStyle(size: 24, color: black)),
              // 40.height,
              Container(
                margin: const EdgeInsets.only(top: 95, bottom: 16, left: 16, right: 16 ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: context.width(),
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: const EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30), backgroundColor: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              50.height,
                              Text("Phone Number", style: boldTextStyle(size: 14)),
                              8.height,
                              AppTextField(
                                decoration: waInputDecoration(hint: 'Enter your Phone Number here', prefixIcon: Icons.phone_android_outlined),
                                textFieldType: TextFieldType.PHONE,
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                focus: emailFocusNode,
                              ),
                              16.height,
                          
                              AppButton(
                                  text: "Log In",
                                  color: WAPrimaryColor,
                                  textColor: Colors.white,
                                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  width: context.width(),
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;                                      
                                    });

                                    //loading
                                      await FirebaseAuth.instance.verifyPhoneNumber(
                                        phoneNumber: "+91${phoneController.text}",
                                        verificationCompleted: (PhoneAuthCredential credential) {},
                                        verificationFailed: (FirebaseAuthException e) {},

                                        codeSent: (String verificationId, int? resendToken) {
                                          // Fluttertoast.showToast(msg: "Code Sent $verificationId");
                                          Navigator.push(context, 
                                            MaterialPageRoute(builder:  (context) => VerificationScreen(verid: verificationId,))
                                          );
                                        },
                                        codeAutoRetrievalTimeout: (String verificationId) {},
                                      );

                                  }).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                              30.height,
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    const Divider(thickness: 2).expand(),
                                    8.width,
                                    Text('or', style: boldTextStyle(size: 16, color: Colors.grey)),
                                    8.width,
                                    const Divider(thickness: 2).expand(),
                                  ],
                                ),
                              ).center(),
                              30.height,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                                    padding: const EdgeInsets.all(16),
                                    child: Image.asset('assets/wa_facebook.png', width: 40, height: 40),
                                  ),
                                  30.width,
                                  Container(
                                    decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
                                    padding: const EdgeInsets.all(16),
                                    child: GoogleLogoWidget(size: 40),
                                  ),
                                ],
                              ).center(),
                              30.height,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account?', style: primaryTextStyle(color: Colors.grey)),
                                  4.width,
                                  Text('Register here', style: boldTextStyle(color: black)),
                                ],
                              ).onTap(() {
                                // VerificationScreen().launch(context, auth);
                              }).center(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: boxDecorationRoundedWithShadow(30, backgroundColor: context.cardColor),
                      // child: const Icon(Icons.av_timer_sharp, size: 60, color: WAPrimaryColor)
                      child: Image.asset(
                        'assets/icon_trans.png',
                        height: 90,
                        width: 90,
                        color: transparentColor,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
