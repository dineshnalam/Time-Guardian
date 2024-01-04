import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timegaurdian/UI/dashboard.dart';
import 'package:timegaurdian/models/task.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:time_range_picker/time_range_picker.dart';
// import 'package:timegaurdian/UI/utils/form_array_item.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class NewContractScreen extends StatefulWidget {
  NewContractScreen({super.key});

  @override
  State<NewContractScreen> createState() => _NewContractScreenState();
}

class _NewContractScreenState extends State<NewContractScreen> {
  final formKey = GlobalKey<FormState>();

  final String title = "New Task";

  String cUid = "cUid";

  String cCity = "";

  String cDomain = "";

  late TimeOfDay startTime;

  late TimeOfDay endTime;

  int cPriority = 0;

  DateTime cDate = DateTime.now();

  TimeOfDay cTime = TimeOfDay(hour: 9, minute: 0);

  String cText = "";

  String cId = FirebaseAuth.instance.currentUser!.uid;

  String cStatus = "created";

  List<String> cLid = [];

  bool isLoading = false;
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    cUid = Uuid().v4();
    cUid = cUid.substring(cUid.length - 6);

    print("Task Unique ID: $cUid");

    final theme = Theme.of(context);

    return isLoading
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: WAPrimaryColor,
                size: 60,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
              elevation: 4.0,
              shadowColor: theme.shadowColor,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FastForm(
                      formKey: formKey,
                      inputDecorationTheme: InputDecorationTheme(
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[700]!, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[500]!, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      children: _buildForm(context),
                      onChanged: (value) {
                        // ignore: avoid_print
                        print('Form changed: ${value.toString()}');
                      },
                    ),
                    AppButton(
                      child: Text('SUBMIT',
                              style: boldTextStyle(color: theme.primaryColor))
                          .paddingSymmetric(horizontal: 32),
                      shapeBorder:
                          RoundedRectangleBorder(borderRadius: radius(30)),
                      elevation: 10,
                      color: theme.secondaryHeaderColor,
                      padding: EdgeInsets.all(15),
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });

                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // formKey.currentState?.value;
                          saveTask(context);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          toast('Invalid Data');
                        }
                      },
                    ).paddingBottom(25),
                  ],
                ),
              ),
            ),
          );
  }

  List<Widget> _buildForm(BuildContext context) {
    DateTime now = new DateTime.now();
    return [
      FastFormSection(
        padding: const EdgeInsets.all(16.0),
        header: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Task ID: $cUid",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        children: [
          FastTextField(
            onSaved: (String? value) {
              cText = value!;
            },
            name: 'text_field',
            labelText: 'Task Details',
            placeholder: 'Briefly explain about the job to be done',
            keyboardType: TextInputType.multiline,
            maxLength: 100,
            prefix: const Icon(Icons.assignment),
            buildCounter: inputCounterWidgetBuilder,
            inputFormatters: const [],
            validator: Validators.compose([
              Validators.required((value) => 'Field is required'),
              Validators.minLength(
                  7,
                  (value, minLength) =>
                      'Field must contain at least $minLength characters')
            ]),
          ),

          FastDropdown(
            onSaved: (Object? value) {
              cDomain = value!.toString();
            },
            name: 'domain',
            labelText: 'Domain',
            items: [
              'Work',
              'Study',
              'Meditate',
              'Workout',
              'Other'
            ],
            initialValue: 'Work',

          ),



          FastCalendar(
            onSaved: (DateTime? value) {
              cDate = value!;
            },
            name: 'date',
            labelText: 'Date of Work',
            initialValue: DateTime(now.year, now.month, now.day),
            firstDate: DateTime(now.year, now.month, now.day),
            lastDate: DateTime(now.year, now.month + 6),
          ),


          Text("Please select the time range for the task"),
          2.height,
          ElevatedButton(
            onPressed: () async {
              TimeRange? result = await showTimeRangePicker(
                context: context,
                rotateLabels: false,
                fromText: "From",
                toText: "To",
                ticks: 24,
                ticksColor: Colors.grey,
                ticksOffset: -12,
                labels: [
                  "12 h",
                  "15 h",
                  "18 h",
                  "21 h",
                  "24 h",
                  "3 h",
                  "6 h",
                  "9 h"
                ].asMap().entries.map((e) {
                  return ClockLabel.fromIndex(
                      idx: e.key, length: 8, text: e.value);
                }).toList(),
                labelOffset: -30,
                padding: 55,
                start: const TimeOfDay(hour: 12, minute: 0),
                end: const TimeOfDay(hour: 18, minute: 0),
                disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 4, minute: 0),
                  endTime: const TimeOfDay(hour: 10, minute: 0),
                ),
                minDuration: const Duration(hours: 0, minutes: 20),
              );
              if (true) {
                print("result $result");
                startTime = result!.startTime;
                endTime = result.endTime;
                valid = true;
              }
            },
            child: const Text("Select Duration"),
          ),
          15.height,

          FastRadioGroup(
            onSaved: (Object? value) {
              cPriority = value as int;
            },
            name: 'priority',
            labelText: 'Task Priority',
            options: const [
              FastRadioOption(title: Text('Low Priority'), value: 0),
              FastRadioOption(title: Text('High Priority'), value: 1),
            ],
          ),

        ],
      ),
    ];
  }

  void saveTask(BuildContext context) {

    if (valid) {

      setState(() {
        isLoading = true;
      });

      DateTime dt = DateTime(
          cDate.year, cDate.month, cDate.day);
      DateTime st = DateTime(
          cDate.year, cDate.month, cDate.day, startTime.hour, startTime.minute);
      DateTime et = DateTime(
          cDate.year, cDate.month, cDate.day, endTime.hour, endTime.minute);

      Task task = Task(
        taskId: cUid,
        domain: cDomain,
        taskText: cText,
        userId: cId,
        status: cStatus,
        date: dt.toString(),
        priority: cPriority,
        start: st.toString(),        
        end: et.toString(),
      );
      print(task.toJson().toString());
      FirebaseFirestore.instance
          .collection("Tasks")
          .doc(cUid)
          .set(task.toJson())
          .then((value) => {
            Fluttertoast.showToast(msg: "Task Created Successfully"),
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (route) => false,
          )
          });
    } else {
              setState(() {
          isLoading = false;
        });
      Fluttertoast.showToast(msg: "Please select valid time range");
    }
  }
}
