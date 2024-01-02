import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timegaurdian/models/template.dart';

class TemplateScreen extends StatelessWidget {

  List<Template> templates = getTemplates();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Template Screen'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 0,
        padding: EdgeInsets.all(10.0),
        children: templates.map((template) {
          return Center(
            child: InfoCard(
              title: template.name,
              body: template.description,
              onMoreTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => template.screen),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}


class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      required this.body,
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.ads_click_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        radius: 20,
      ),
      this.subInfoText = "Use Template",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 0.0, top: 0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: RadialGradient(
            colors: [Color.fromARGB(255, 255, 124, 64), Colors.orange],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

            ],
          ),
          SizedBox(height: 5),
          Text(
            body,
            style:
                TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
          ),
          SizedBox(height: 10),

          GestureDetector(
            onTap: onMoreTap,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    subIcon,
                    SizedBox(width: 3),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subInfoText,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
