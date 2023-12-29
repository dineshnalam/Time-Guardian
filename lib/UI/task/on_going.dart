import 'package:timegaurdian/UI/homepage.dart';
import 'package:timegaurdian/models/task.dart';
import 'package:timegaurdian/utils/app_constants.dart';
import 'package:timegaurdian/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timegaurdian/utils/widgets.dart';



class OnGoingContractsScreen extends StatefulWidget {
  const OnGoingContractsScreen({super.key});


  @override
  OnGoingContractsScreenState createState() => OnGoingContractsScreenState();
}

class OnGoingContractsScreenState extends State<OnGoingContractsScreen> {
  int selectedPos = 1;
  late List<Task> mListings;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings = getDummyTasks();
    // mListings.removeWhere((contract) => contract.status != 'In Progress');
    
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    setStatusBarColor(white);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TOPBAAR
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: white,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_left, size: 45),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => ContractorHomePage()), (Route route) => false);
                      },
                    ),
                    Center(child: text("On Going Contracts", textColor: black, fontSize: textSizeNormal, fontFamily: fontBold))
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20.0, top: 20),
            //   child: text(t5_history, textColor: black, fontFamily: fontBold, fontSize: textSizeXLarge),
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 0),
                margin: EdgeInsets.only(top: 0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mListings.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime dt = DateTime.parse(mListings[index].date);
                      List<String> months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec'
                      ]; 
                      return ExpansionTile(
                        
                        tilePadding: EdgeInsets.all(0),
                        title: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 0, bottom: 18),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      text(months[dt.month-1], fontSize: textSizeSMedium),
                                      text(dt.day.toString(), fontSize: textSizeLargeMedium, textColor: black),
                                    ],
                                  ),
                                  Container(
                                    decoration: boxDecoration(radius: 8, showShadow: true),
                                    margin: EdgeInsets.only(left: 16, right: 16),
                                    width: width / 7.2,
                                    height: width / 7.2,
                                    child: SvgPicture.asset(getIcon(mListings[index].domain)),
                                    padding: EdgeInsets.all(width / 30),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            text(mListings[index].taskId, textColor: black, fontSize: textSizeMedium, fontFamily: fontSemibold),
                                            // text(mListings[index].status, textColor: black, fontSize: textSizeMedium, fontFamily: fontSemibold)
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        ),
                                        text(mListings[index].domain, fontSize: textSizeMedium)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(height: 0.5, color: t5ViewColor)
                          ],
                        ),
                        
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        childrenPadding: EdgeInsets.only(left: 32, top: 16, bottom: 16),
                        collapsedIconColor: context.iconColor,
                        iconColor: context.iconColor,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Id :',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].taskId, style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          2.height,
                          Text.rich(
                            TextSpan(
                              text: 'Work Date :',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].status, style: secondaryTextStyle(color: Colors.blueAccent)),
                              ],
                            ),
                          ),
                          2.height,
                          Text.rich(
                            TextSpan(
                              text: 'Work Date :',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].date, style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          2.height,
                          Text.rich(
                            TextSpan(
                              text: 'Domain : ',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].domain, style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          2.height,

                          Divider(
                            endIndent: 32,
                            color: Colors.black54,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Start Time : ',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].start.toString(), style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          2.height,
                          Text.rich(
                            TextSpan(
                              text: 'End Time  : ',
                              style: primaryTextStyle(),
                              children: <InlineSpan>[
                                TextSpan(text: mListings[index].end.toString(), style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          4.height,
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.all(4),
                                decoration: boxDecorationDefault(border: Border.all(color: Colors.black26)),
                                child: Icon(
                                  Icons.sports_handball,
                                  color: Colors.black54,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.all(4),
                                decoration: boxDecorationDefault(border: Border.all(color: Colors.black26)),
                                child: Icon(
                                  Icons.apartment_outlined,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String getIcon(String domain){
    switch (domain) {
      case "Construction":
        return "assets/t5_translate.svg";
      case "Plumber":
        return "assets/t5_drop.svg";
      case "Electrician":
        return "assets/t5_light_bulb.svg";
      default:
        return "assets/t5_wifi.svg";
    }
  }
}



