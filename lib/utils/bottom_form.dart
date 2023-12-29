import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timegaurdian/models/task.dart';
import 'package:timegaurdian/models/contractor.dart';
import 'package:timegaurdian/utils/app_constants.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

BottomFormSheet(BuildContext aContext, Task task) async {
  String cName = "contractor Name";
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("ContractorCol").doc(task.userId).get();
  Contractor contractor = Contractor.fromJson(snapshot.data() as Map<String, dynamic>);
  cName = contractor.name;
  // ignore: use_build_context_synchronously
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: aContext,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: white),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Current Job",
              style: boldTextStyle(color: black),
            ),
            const Divider().paddingOnly(top: 6, bottom: 6),
            Text(
              "Contract Id: ${task.taskId}",
              style: primaryTextStyle(color: black),
            ),
            7.height,

            Text(
              "Contractor Name: ${contractor.name}",
              style: primaryTextStyle(color: black),
            ),
            7.height,

            Text(
              "Contract Phone No : ${contractor.phoneNo}",
              style: primaryTextStyle(color: black),
            ),
            7.height,

            Text(
              "Contract Description: ${task.taskText}",
              style: primaryTextStyle(color: black),
            ),
            11.height,

            Text(
              "Contract Status : ${task.status}",
              style: primaryTextStyle(color: black, fontStyle: FontStyle.italic,),
            ),
            4.height,

            // editTextStyle("Status"),
            
            16.height,

            GestureDetector(
              onTap: () {
                print("object");
                
    showConfirmDialogCustom(
      aContext,
      title: "Do you want to update this item?",
      dialogType: DialogType.UPDATE,
      onAccept: (v) {
        snackBar(context, title: 'Updated');
      },
    );
  
                finish(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: boxDecoration(bgColor: primaryUtilityTrackerColor, radius: 16),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Center(
                  child: Text(
                    "Finish Contract",
                    style: primaryTextStyle(color: containerColor),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

accept() {
  Fluttertoast.showToast(msg: "accepted");
}


Padding editTextStyle(var hintText) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextFormField(
      style: const TextStyle(fontSize: 16, fontFamily: fontRegular),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        hintText: hintText,
        hintStyle: primaryTextStyle(color:  grey),
        filled: true,
        fillColor: white,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: gray, width: 1.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: gray, width: 1.0)),
      ),
    ),
  );
}