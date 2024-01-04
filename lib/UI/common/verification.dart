import 'package:timegaurdian/UI/common/edit_profile.dart';
import 'package:timegaurdian/services/firebase_const.dart';
import 'package:timegaurdian/utils/app_constants.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart' as otp;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timegaurdian/UI/homepage.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatefulWidget {
  String verid;
  VerificationScreen({super.key, required this.verid});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  OtpFieldController otpController = OtpFieldController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: context.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: const Icon(Icons.arrow_back, color: black),
        ).onTap(() {
          finish(context);
        }),
      ),
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.height,
              Image.asset('assets/wa_verification.png'),
              8.height,
              Text(
                'Verification',
                style: boldTextStyle(size: 20, color: black),
                textAlign: TextAlign.center,
              ),
              16.height,
              Text(
                'We have send a 6 digit verification code to your Phone. Please enter the code below to verify it\'s you',
                style: secondaryTextStyle(color: gray),
                textAlign: TextAlign.center,
              ),
              30.height,
              Wrap(
                children: [
                  SizedBox(
                    height: 60,
                    child: otp.OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: context.width(),
                      fieldWidth: 40,
                      style: boldTextStyle(size: 24, color: black),
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor: WAPrimaryColor,
                        backgroundColor: Colors.grey.withOpacity(0.1),
                        enabledBorderColor: Colors.transparent,
                      ),
                      onChanged: (value) {},
                      onCompleted: (value) async {
                        setState(() {isLoading = true;});

                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verid, smsCode: value);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          Fluttertoast.showToast(msg: "Verified User");
                          postVerified();
                        }).catchError((e) {
                          Fluttertoast.showToast(msg: e.toString());
                          setState(() {isLoading = false;});
                        });

                      },
                    ),
                  ),
                ],
              ),
              16.height,
              Row(
                children: [
                  Text('I didn\'t get the Code.',
                      style: secondaryTextStyle(color: gray)),
                  4.width,
                  Text('Resend Code',
                      style: boldTextStyle(color: WAPrimaryColor),
                      textAlign: TextAlign.center),
                ],
              ),
              16.height,
              SizedBox(
                width: context.width() * 0.5,
                child: AppButton(
                  text: "Verify Me",
                  color: WAPrimaryColor,
                  textColor: Colors.white,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  width: context.width(),
                  onTap: () async {
                    setState(() {isLoading = true;});

                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verid,
                            smsCode: otpController.getOtp());
                    await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) {
                      Fluttertoast.showToast(msg: "Verified User");
                      postVerified();
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                      setState(() {isLoading = false;});
                    });

                  },
                ),
              ),
            ],
          ).paddingAll(30),
        ),
      ),
    );
  }

  void postVerified() async {

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final userSnpashot = await usersRef.doc(uid).get();

    if (userSnpashot.exists) {
      //Existing User
      Fluttertoast.showToast(msg: "Existing User");
      ContractorHomePage().launch(context);
    } else {
      setState(() {isLoading = false;});
      Fluttertoast.showToast(msg: "New User");

      EditProfileScreen(isContractor: true, isEditProfile: false,).launch(context);
      
    }
  }
}
