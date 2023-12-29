import 'package:timegaurdian/UI/common/notification.dart';
// import 'package:timegaurdian/utils/Expandable.dart';
import 'package:timegaurdian/utils/app_constants.dart';
import 'package:timegaurdian/utils/colors.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';


class SettingsScreen extends StatefulWidget {
  static var tag = "/settings";

  final bool isDirect;

  SettingsScreen({this.isDirect = false});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  int selectedPos = 1;
  bool notification = false;
  bool discounts = false;
  bool gift = false;
  bool fastPayment = false;
  // ExpandableController _controller = new ExpandableController();
  String? _selectedLocation = 'English';

  late double width;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
  }

  Widget settingItem(String name, {String icon = "", var pad = 16.0}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 18),
              width: width / 7.5,
              height: width / 7.5,
              padding: EdgeInsets.all(width / 30),
              decoration: icon.isNotEmpty ? boxDecoration(radius: 4, bgColor: context.scaffoldBackgroundColor, showShadow: true) : null,
              child: icon.isNotEmpty ? SvgPicture.asset(icon) : SizedBox(),
            ),
            text(name, textColor: black, fontFamily: fontMedium, fontSize: textSizeLargeMedium)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = context.width();
    setStatusBarColor(white);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopBar(isDirect: widget.isDirect),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10),
              child: text("Settings", textColor: black, fontFamily: fontBold, fontSize: textSizeXLarge),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 24),

                                            Row(
                        children: <Widget>[
                          settingItem("Language", icon: "assets/t5_translate.svg"),
                          CustomTheme(
                            child: DropdownButton<String>(
                              icon: Icon(Icons.keyboard_arrow_right, color: t5TextColorSecondary),
                              underline: SizedBox(),
                              value: _selectedLocation,
                              items: <String>['English', 'French', 'German'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: text(value, fontSize: textSizeLargeMedium, textColor: black),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 16)
                        ],
                      ),
                      divider(),

                      Row(
                        children: <Widget>[
                          settingItem("Notification", icon: "assets/t5_notification.svg"),
                          Switch(
                            value: fastPayment,
                            onChanged: (value) {
                              setState(() {
                                fastPayment = value;
                              });
                            },
                            activeTrackColor: t5ColorPrimary,
                            activeColor: t5White,
                          ).paddingRight(10)
                        ],
                      ),
                      divider(),

                      Row(
                        children: <Widget>[
                          settingItem("Rate Us", icon: "assets/rating.svg"),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: t5TextColorSecondary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      divider(),

                      Row(
                        children: <Widget>[
                          settingItem("About", icon: "assets/about.svg"),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: t5TextColorSecondary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: child!,
    );
  }
}


// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;
  final bool isDirect;

  TopBar({var this.titleName = "", this.isDirect = false});

  @override
  State<StatefulWidget> createState() {
    return TopBarState(isDirect: isDirect);
  }
}

class TopBarState extends State<TopBar> {
  final bool isDirect;

  TopBarState({this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: white,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, size: 45),
              onPressed: () {
                if (isDirect.validate()) {
                  NotificationScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                } else {
                  finish(context);
                }
              },
            ),
            Center(child: text(widget.titleName, textColor: black, fontSize: textSizeNormal, fontFamily: fontBold))
          ],
        ),
      ),
    );
  }
}

Widget divider() {
  return Divider(
    height: 0.5,
    color: t5ViewColor,
  );
}