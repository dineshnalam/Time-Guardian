import 'package:cached_network_image/cached_network_image.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? black,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? white,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

InputDecoration waInputDecoration({IconData? prefixIcon, String? hint, Color? bgColor, Color? borderColor, EdgeInsets? padding}) {
  return InputDecoration(
    contentPadding: padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: Offstage(),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor ?? WAPrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? WAPrimaryColor.withOpacity(0.04),
    hintText: hint,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: WAPrimaryColor) : null,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}

Widget waCommonCachedNetworkImage(
  String? url, {
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  bool usePlaceholderIfUrlEmpty = true,
  double? radius,
  Color? color,
}) {
  if (url!.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('assets/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget? Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();
Widget placeholderWidget() => Image.asset('assets/placeholder.jpg', fit: BoxFit.cover);



// ignore: must_be_immutable
// class TopBar extends StatefulWidget {
//   var titleName;
//   final bool isDirect;

//   TopBar({var this.titleName = "", this.isDirect = false});

//   @override
//   State<StatefulWidget> createState() {
//     return TopBarState(isDirect: isDirect);
//   }
// }

// class TopBarState extends State<TopBar> {
//   final bool isDirect;

//   TopBarState({this.isDirect = false});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 60,
//         color: white,
//         child: Stack(
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.keyboard_arrow_left, size: 45),
//               onPressed: () {
//                 if (isDirect.validate()) {
//                   NotificationScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
//                 } else {
//                   finish(context);
//                 }
//               },
//             ),
//             Center(child: text(widget.titleName, textColor: black, fontSize: textSizeNormal, fontFamily: fontBold))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MessagesComponent extends StatelessWidget {
//   const MessagesComponent({Key? key, this.messageData}) : super(key: key);

//   final UtilityTrackerModel? messageData;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('${messageData!.messagesName!}', style: secondaryTextStyle(color: Colors.black)),
//             Text('${messageData!.lastSeen!} min ago', style: secondaryTextStyle(color: Colors.black)),
//           ],
//         ),
//         8.height,
//         Text('${messageData!.complainText!}', style: boldTextStyle(size: 18, color: Colors.black)),
//       ],
//     );
//   }
// }

// class UtilityTrackerListComponent extends StatelessWidget {

//   const UtilityTrackerListComponent({Key? key, this.data}) : super(key: key);

//   final UtilityTrackerModel? data;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(color: primaryUtilityTrackerColor, borderRadius: radius(40)),
//           child: Image.asset(data!.utilityIcons!, height: 20, width: 20),
//         ),
//         25.height,
//         Text('\u20AC ${data!.utilityAmount!}', style: boldTextStyle(size: 20, color: Colors.black)),
//         8.height,
//         Text('${data!.utilityTitle}', style: secondaryTextStyle(color: Colors.black)),
//       ],
//     );
//   }
// }
