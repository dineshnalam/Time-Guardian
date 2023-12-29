import 'package:timegaurdian/UI/homepage.dart';
import 'package:timegaurdian/models/contractor.dart';
import 'package:timegaurdian/models/worker.dart';
import 'package:timegaurdian/services/firebase_const.dart';
import 'package:timegaurdian/utils/models.dart';
import 'package:timegaurdian/utils/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:nb_utils/nb_utils.dart';


class EditProfileScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isEditProfile;
  final isContractor;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  EditProfileScreen({this.isEditProfile, this.isContractor});


  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  var fullNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
  // var contactNumberController = TextEditingController();
  String cCity = "";
  String domain = "";
  String cName = "";
  late List<String> cDomain ;


  FocusNode fullNameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();


  @override
  void initState() {
    setStatusBarColor(white);
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    if(widget.isEditProfile){
      title="Edit Profile";
    }else{
      title = "Register";
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(Icons.arrow_back, color: black),
          ).onTap(() {
            finish(context);
          }),
          centerTitle: true,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark) ,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                width: context.width(),
                height: context.height(),
                decoration: boxDecorationWithShadow(backgroundColor: context.cardColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Information', style: boldTextStyle(size: 18)),
                      16.height,

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

 
                      16.height,
                      AppButton(
                        color: WAPrimaryColor,
                        width: context.width(),
                        child: Text('Continue', style: boldTextStyle(color: Colors.white)),
                        onTap: () {
                          if (widget.isEditProfile) {
                            finish(context);
                          } else {
                            //go to post register
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              // formKey.currentState?.value;
                            Fluttertoast.showToast(msg: "Epid_Profile: Post Register");
                            postRegister();
                            }else{
                                toast('Invalid Data');
                            }

                          }
                        },
                      ).cornerRadiusWithClipRRect(30).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(color: WAPrimaryColor, shape: BoxShape.circle),
                    child: const Icon(Icons.person, color: white, size: 60),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: WAAccentColor, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext context) {
    return [
      FastFormSection(
        // padding: const EdgeInsets.all(16.0),
        children: [
          FastTextField(
            onSaved: (String? value){cName = value!;},
            name: 'Full Name',
            labelText: 'Full Name',
            placeholder: 'Enter your full name',
            keyboardType: TextInputType.name,
            maxLength: 20,
            prefix: const Icon(Icons.engineering),
            buildCounter: inputCounterWidgetBuilder,
            inputFormatters: const [],
            validator: Validators.compose([
              Validators.required((value) => 'Enter your name'),
            ]),
          ),

          Text('Domains', style: boldTextStyle(size: 14)).visible(!widget.isContractor),
          3.height.visible(widget.isContractor),

          FastChoiceChips(
            onSaved: (List<String>? value){cDomain = value!;},
            
            name: "domain", 
            labelText: "Select Domains",
            alignment: WrapAlignment.center,
            chipPadding: const EdgeInsets.all(8),
            validator: (value) => value == null || value.isEmpty
              ? 'Please select atleast one Domain'
              :null,
            chips: [
              FastChoiceChip(
                value: "Electrician",
                avatar: const Icon(Icons.electrical_services_outlined)
              ),
              FastChoiceChip(
                value: "Plumber",
                avatar: const Icon(Icons.plumbing)
              ),
              FastChoiceChip(
                value: "Construction",
                avatar: const Icon(Icons.construction)
              ),
              FastChoiceChip(
                value: "Carpenter",
                avatar: const Icon(Icons.carpenter)
              ),
            ]
          ).visible(!widget.isContractor),
          16.height,


          Text('City', style: boldTextStyle(size: 14)),
          3.height,

          FastDropdown<String>(
            onSaved: (String? value){cCity = value!;},
            name: 'city',
            labelText: 'City of Work',
            items: ['Hyderabad', 'Mumbai', 'Chennai', 'Banglaore', 'Delhi'],
            initialValue: 'Hyderabad',
          ),



        ],
      ),
    ];
  }
  
  void postRegister() {
    //save user
    if(widget.isContractor){
      //Create Contractor user
      Contractor contractor = Contractor(
        uid: FirebaseAuth.instance.currentUser?.uid, 
        name: cName, 
        phoneNo: FirebaseAuth.instance.currentUser?.phoneNumber, 
        city: cCity
      );
      usersRef.doc(contractor.uid).set(contractor.toJson());
      FirebaseAuth.instance.currentUser!.updateDisplayName(cName);
      ContractorHomePage().launch(context);

    }
      
    }

    
  }

