import 'package:timegaurdian/UI/common/edit_profile.dart';
import 'package:timegaurdian/UI/common/main_login.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/fullApps/walletApp/screen/WAEditProfileScreen.dart';
// import 'package:prokit_flutter/fullApps/walletApp/utils/WAWidgets.dart';
// import 'package:prokit_flutter/main/utils/AppConstant.dart';

class WAMyProfileScreen extends StatefulWidget {
  static String tag = '/WAMyProfileScreen';

  @override
  WAMyProfileScreenState createState() => WAMyProfileScreenState();
}

class WAMyProfileScreenState extends State<WAMyProfileScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(white);
    init();
  }

  init() async {
    //
  }

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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('My Profile', style: boldTextStyle(color: Colors.black, size: 20)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                waCommonCachedNetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB8vuaWT6wGaoDz6T0UEilQ8wwcFO-hvserEgijbpPulSLBBpgbkxZBjwhUsU3ULuPazM&usqp=CAU',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ).cornerRadiusWithClipRRect(60),
                16.height,
                Text('Rick Astley', style: boldTextStyle()),
                Text('9876543210', style: secondaryTextStyle()),
                16.height,
                SettingItemWidget(
                    title: 'Edit Profile',
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      EditProfileScreen(isEditProfile: true).launch(context);
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Tasks History',
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      //
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Settings',
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      //
                    }),
                16.height,
                SettingItemWidget(
                    title: 'Logout',
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                        return LoginScreen();
                      }), (r){
                        return false;
                      });
                    }),
              ],
            ).paddingAll(16),
          ),
        ),
      ),
    );
  }
}
