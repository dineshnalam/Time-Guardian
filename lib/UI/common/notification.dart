import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class NotificationScreen extends StatefulWidget {
  static var tag = "/no_notification1";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    setStatusBarColor(Color(0xFFFFC655));
    super.initState();
  }

  // @override
  // void dispose() {
  //   setStatusBarColor(appStore.scaffoldBackground!);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: SemiCircleClipper(),
                  child: Container(
                    height: context.height() * 0.5,
                    decoration: BoxDecoration(color: Color(0xFFFFC655)),
                  ),
                ),
                150.height,
                Text('No Notification', style: boldTextStyle(size: 20)),
                16.height,
                Text(
                  "No New Notifications",
                  style: secondaryTextStyle(size: 15),
                  textAlign: TextAlign.center,
                ).paddingSymmetric(vertical: 8, horizontal: 60),
              ],
            ),
            Image.asset('assets/bell.png', height: 180),
          ],
        ),
      ),
      
    );
  }
}

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 60;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
