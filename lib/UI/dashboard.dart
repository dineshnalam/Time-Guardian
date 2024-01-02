import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timegaurdian/UI/calendar/calendar.dart';
import 'package:timegaurdian/UI/calendar/calendar2.dart';
import 'package:timegaurdian/UI/common/rateus.dart';
import 'package:timegaurdian/UI/common/settings.dart';
import 'package:timegaurdian/UI/pomodoro/homeScreen.dart';
import 'package:timegaurdian/UI/task/history.dart';
import 'package:timegaurdian/UI/task/new_task.dart';
import 'package:timegaurdian/UI/task/on_going.dart';
import 'package:timegaurdian/UI/templates/templates.dart';
// import 'package:timegaurdian/utils/bottom_form.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/SliderWidget.dart';
import 'package:timegaurdian/models/task.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key});
  // static String tag = '/e_wallet';
  // final bool isDirect;
  // Dashboard4({this.isDirect = false});

  @override
  DashboardScreenState createState() =>
      DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = true;

  List<Db4Category>? mFavouriteList;
  List<Task> mSliderList = [];

  @override
  void initState() {
    getMyContracts();
    mFavouriteList = GetCategoryItems();
    super.initState();
  }

  Future<void> getMyContracts() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // Query the "Contracts" collection for documents where uid matches the current user's UID
    final snapshot = await FirebaseFirestore.instance
        .collection('Tasks')
        .where('userId', isEqualTo: uid)
        .where('status', isEqualTo: 'created')
        .get();

    final List<Task> temp = snapshot.docs
        .map((documentSnapshot) =>
            Task.fromJson(documentSnapshot.data() as Map<String, dynamic>))
        .toList();

    print("Triggered get");

    mSliderList = temp;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color.fromARGB(255, 52, 52, 149));

    var width = MediaQuery.of(context).size.width;
    width = width - 70;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      // minimum: const EdgeInsets.all(32.0),
      child: isLoading
          ? Scaffold(
              body: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: WAPrimaryColor,
                  size: 60,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: const Color.fromARGB(255, 52, 52, 149),
              key: _scaffoldKey,
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 28),
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height - 100,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF6F7FA),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Column(
                        children: <Widget>[
                          SliderWidget(mSliderList),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: GridListing(mFavouriteList, stateFunc),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: const EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/db_profile.jpeg"),
                            radius: 25),
                        const SizedBox(width: 16),
                        Text(
                          "Hi, ${FirebaseAuth.instance.currentUser!.displayName.toString()}",
                          style: primaryTextStyle(
                              color: white, size: 20, fontFamily: 'Medium'),
                        ).expand(),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.settings_outlined,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                        ),
                        16.width,
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  stateFunc() {
    setState(() {
      isLoading = false;
    });
  }
}

// ignore: must_be_immutable
class SliderWidget extends StatelessWidget {
  List<Task>? mSliderList;

  SliderWidget(this.mSliderList);
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    final Size cardSize = Size(width, width / 1.8);

    return isLoading
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: primaryUtilityTrackerColor,
                size: 60,
              ),
            ),
          )
        : CarouselSliderWidget(
            viewportFraction: 0.9,
            height: cardSize.height,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            items: mSliderList!.map((slider) {
              DateTime dt = DateTime.parse(slider.date);

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 38, 38, 111),
                      borderRadius: radius(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Task Id: ${slider.taskId}',
                                style: secondaryTextStyle(color: Colors.white)),
                            Text(
                                'Due: ${dt.day.toString()} ${months[dt.month - 1]}',
                                style: secondaryTextStyle(color: Colors.white)),
                          ],
                        ),
                        10.height,
                        Text('Task : ${slider.taskText}',
                            style:
                                boldTextStyle(color: Colors.white, size: 24)),
                        12.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Status : ',
                                style: secondaryTextStyle(
                                    color: Colors.white, size: 15)),
                            Text('${slider.status}',
                                style: secondaryTextStyle(
                                    color: Colors.white, size: 15)),
                          ],
                        ),
                        25.height,
                        SizedBox(
                          width: context.width(),
                          child: AppButton(
                            text: 'Task Details',
                            textStyle: boldTextStyle(
                                color: const Color.fromARGB(255, 52, 52, 149)),
                            color: whiteSmoke,
                            padding: const EdgeInsets.all(10),
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: white),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Current Task Details",
                                          style: boldTextStyle(color: black),
                                        ),
                                        const Divider()
                                            .paddingOnly(top: 6, bottom: 6),
                                        Text(
                                          "Task Id: ${slider.taskId}",
                                          style: primaryTextStyle(color: black),
                                        ),
                                        7.height,

                                        Text(
                                          "Date: ${slider.date}",
                                          style: primaryTextStyle(color: black),
                                        ),
                                        7.height,

                                        Text(
                                          "Time : ${slider.start} To : ${slider.end}",
                                          style: primaryTextStyle(color: black),
                                        ),
                                        7.height,

                                        Text(
                                          "Task Description: ${slider.taskText}",
                                          style: primaryTextStyle(color: black),
                                        ),
                                        7.height,

                                        Text(
                                          "Task Status : ${slider.status}",
                                          style: primaryTextStyle(
                                            color: black,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        7.height,

                                        // editTextStyle("Status"),
                                        // 16.height,
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Confirmation"),
                                                  content: Text( "Are you sure you want to end the task?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        updateTaskStatus(slider.taskId, context);

                                                        Navigator.of(context)
                                                            .pop();
                                                        
                                                      },
                                                      child: Text("Yes"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            Fluttertoast.showToast(msg: "msg");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: boxDecoration(
                                                bgColor:
                                                    primaryUtilityTrackerColor,
                                                radius: 16),
                                            padding: EdgeInsets.fromLTRB(
                                                16, 16, 16, 16),
                                            child: Center(
                                              child: Text(
                                                "Close",
                                                style: primaryTextStyle(
                                                    color: containerColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
  }

    void updateTaskStatus(String taskId, BuildContext context) {

    FirebaseFirestore.instance
        .collection('Tasks')
        .doc(taskId)
        .update({'status': 'completed'})
        .then((value) {
          Fluttertoast.showToast(msg: "Task Completed");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (route) => false,
          );
    }).catchError((error) {
      // Fluttertoast.showToast(msg: "Failed to update task status: $error");
      print("Failed to update task status: $error");
    });
  }

}

// ignore: must_be_immutable
class GridListing extends StatelessWidget {
  List<Db4Category>? mFavouriteList;
  bool isLoading = false;
  final Function() notifyParent;

  GridListing(this.mFavouriteList, this.notifyParent);

  @override
  Widget build(BuildContext context) {
    var width = context.width();

    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mFavouriteList!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            notifyParent();
            switch (mFavouriteList![index].name) {
              case "New":
                Fluttertoast.showToast(msg: "New");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewContractScreen()),
                );
                break;
              case "Existing":
                Fluttertoast.showToast(msg: "Existing");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContractorHistoryScreen()),
                );
                break;
              case "Calendar":
                Fluttertoast.showToast(msg: "Calendar");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
                break;
              case "Template Hub":
                Fluttertoast.showToast(msg: "Template Hub");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TemplateScreen()),
                );
                break;
              case "Pomodoro":
                Fluttertoast.showToast(msg: "Pomodoro");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PomoScreen()),
                );
                break;
              case "More":
                Fluttertoast.showToast(msg: "More");
                break;
              default:
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: white,
                boxShadow: defaultBoxShadow(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width / 7.5,
                  width: width / 7.5,
                  margin: const EdgeInsets.only(bottom: 4, top: 8),
                  padding: EdgeInsets.all(width / 30),
                  decoration: BoxDecoration(
                      color: mFavouriteList![index].color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: SvgPicture.asset(
                    mFavouriteList![index].icon,
                    color: white,
                  ),
                ),
                Text(
                  mFavouriteList![index].name,
                  style: secondaryTextStyle(size: 14),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

List<Db4Category> GetCategoryItems() {
  List<Db4Category> list = [];

  var category1 = Db4Category();
  category1.name = "New";
  category1.color = const Color(0xFF45c7db);
  category1.icon = "assets/db4_paperplane.svg";
  list.add(category1);
  var category2 = Db4Category();
  category2.name = "Existing";
  category2.color = const Color(0xFF510AD7);
  category2.icon = "assets/db4_wallet.svg";
  list.add(category2);
  var category3 = Db4Category();
  category3.name = "Calendar";
  category3.color = const Color(0xFFe43649);
  category3.icon = "assets/db4_coupon.svg";
  list.add(category3);
  var category4 = Db4Category();
  category4.name = "Rating";
  category4.color = const Color(0xFFf4b428);
  category4.icon = "assets/db4_invoice.svg";
  // list.add(category4);

  var category5 = Db4Category();
  category5.name = "Pomodoro";
  category5.color = const Color(0xFF22ce9a);
  category5.icon = "assets/db4_dollar_exchange.svg";
  list.add(category5);

  var category = Db4Category();
  category.name = "Template Hub";
  category.color = const Color(0xFF203afb);
  category.icon = "assets/db4_circle.svg";
  list.add(category);
  return list;
}
