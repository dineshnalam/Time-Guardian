import 'package:flutter/material.dart';

class UtilityTrackerModel {
  String? userName;
  String? profileIcon;
  String? month;
  String? days;
  String? amount;
  String? utilityIcons;
  String? utilityAmount;
  String? utilityTitle;
  String? messagesName;
  String? complainText;
  String? lastSeen;

  UtilityTrackerModel({
    this.userName,
    this.profileIcon,
    this.month,
    this.days,
    this.amount,
    this.utilityIcons,
    this.utilityAmount,
    this.utilityTitle,
    this.messagesName,
    this.complainText,
    this.lastSeen,
  });
}

UtilityTrackerModel userData = UtilityTrackerModel(
  userName: 'Minnie Lehmann',
  profileIcon: "assets/img_user.jpg",
  month: 'August',
  days: '5',
  amount: '431.90',
);


const primaryUtilityTrackerColor = Color(0xFFFFE7Ab);
const containerColor = Color(0xFF2A2721);
const scaffoldBackgroundColor = Color(0xFFF7F6F0);
const utilitySecondaryTextColor = Color(0xFF848484);

const WAPrimaryColor = Color(0xFF6C56F9);
const WAAccentColor = Color(0xFF26C884);

List<String?> waMonthList = <String?>["Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
List<String?> waYearList = <String?>["1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2020", "2021"];

List<WAWalkThroughModel> waWalkThroughList() {
  List<WAWalkThroughModel> list = [];
  list.add(WAWalkThroughModel(
      title: "Let's Connect",
      description: "Contrato provides a platform to Connect Contractors and Workers",
      image: 'assets/wa_walkthorugh.png'));
  list.add(WAWalkThroughModel(
      title: "Contracts",
      description: "Contractors can post jobs on various domains across locations",
      image: 'assets/wa_walkthorugh.png'));
  list.add(WAWalkThroughModel(
      title: "Track Status",
      description: "Workers update the status of the job time to time, allowing contractor to seemlessly keep track of progress",
      image: 'assets/wa_walkthorugh.png'));

  return list;
}

class WAWalkThroughModel {
  String? title;
  String? description;
  String? image;

  WAWalkThroughModel({this.title, this.description, this.image});
}


class Db4Category {
  var name = "";
  Color? color;

  var icon = "";
}

class Db4Slider {
  var image = "";
  var balance = "";
  var accountNo = "";
}

