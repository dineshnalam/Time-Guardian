import 'package:timegaurdian/UI/common/notification.dart';
import 'package:timegaurdian/UI/common/profile.dart';
import 'package:timegaurdian/UI/dashboard.dart';
import 'package:timegaurdian/UI/task/history.dart';
import 'package:timegaurdian/utils/BubbleBotoomBar.dart';
import 'package:flutter/material.dart';

class ContractorHomePage extends StatefulWidget {
  const ContractorHomePage({super.key});


  @override
  ContractorHomePageState createState() => ContractorHomePageState();  
}

class ContractorHomePageState extends State<ContractorHomePage>{
  int currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    ContractorHistoryScreen(),
    const NotificationScreen(),
    WAMyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(  
      bottomNavigationBar: BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      elevation: 8,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      hasNotch: false,
      hasInk: true,
      inkColor: Color(0X505104D7),
      items: <BubbleBottomBarItem>[
        tab("assets/db4_home.svg", "Home"),
        tab("assets/db4_list_check.svg", " History"),
        tab("assets/db4_notification.svg", "Notification"),
        tab("assets/db4_user.svg", "Profile"),
      ],
    ),
    body: _pages[currentIndex],
    );
  }
  
}
