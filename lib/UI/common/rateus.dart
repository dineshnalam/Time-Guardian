import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RateScreen extends StatefulWidget {
    const RateScreen({Key? key});

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double _currentSliderValue = 20;

  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String? rateType;

  String getRate(double num) {
    if (num == 0) {
      return rateType = "Bad";
    } else if (num == 25) {
      return rateType = "Upsad";
    } else if (num == 50) {
      return rateType = "Nice";
    } else if (num == 75) {
      return rateType = "Fabulous";
    } else {
      return rateType = "Awesome";
    }
  }

  String? rateImg;

  String getRateImg(double num) {
    if (num == 0) {
      return rateImg = "assets/t14_bad.png";
    } else if (num == 25) {
      return rateImg = "assets/t14_upSad.png";
    } else if (num == 50) {
      return rateImg = "assets/t14_nice.png";
    } else if (num == 75) {
      return rateImg = "assets/t14_fabulous.png";
    } else {
      return rateImg = "assets/t14_AweSome.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text("Rate Us", style: boldTextStyle(size: 18, color: Color(0xFF002551))),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.close, size: 20),
              onPressed: () {
                finish(context);
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("How was your Experience?", textAlign: TextAlign.center, style: boldTextStyle(color: Color(0xFF002551), size: 28)),
          commonCachedNetworkImage(getRateImg(_currentSliderValue), height: 200, fit: BoxFit.cover),
          Column(
            children: [
              Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  activeColor: Color(0xFFFD4563),
                  divisions: 4,
                  label: getRate(_currentSliderValue),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  }),
              32.height,
              t14AppButton(
                context,
                btnText: "Save",
                bgColor: Color(0xFFE3F9FD),
                width: context.width(),
                shape: 10.0,
                txtColor: Color(0xFF70B6FC),
              ),
            ],
          )
        ],
      ).paddingAll(16),
    );
  }
}


Widget t14AppButton(BuildContext context, {required String btnText, Color? bgColor, required double width, required double shape, Function? onPress, Color? txtColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: bgColor,
      elevation: 0.0,
      padding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(shape)),
    ),
    onPressed: () {
      if (onPress != null) {
        onPress.call();
      }
    },
    child: Text(btnText, style: boldTextStyle(color: txtColor, size: 14)),
  ).withWidth(width);
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('assets/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget commonCachedNetworkImage(
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