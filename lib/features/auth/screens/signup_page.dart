import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/theme/pallete.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:pinput/pinput.dart';

import '../../../core/globals/local_variables.dart';
import '../../../core/utils/utils.dart';
import '../../../model/user_model.dart';
import '../../home/screen/home.dart';
import '../controller/auth_controller.dart';

class OtpSignUpPage extends ConsumerStatefulWidget {
  var otp;
  UserModel newUser;
  OtpSignUpPage({
    super.key,
    required this.otp,
    required this.newUser,
  });
  @override
  _OtpSignUpPageState createState() => _OtpSignUpPageState();
}

class _OtpSignUpPageState extends ConsumerState<OtpSignUpPage> {
  // tel.Telephony telephony = tel.Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  int start = 30;
  bool? verificationComplete;
  List<UserModel> userList = [];
  void resetOtp() async {
    String randomNumber = widget.otp;
    // int randomNumber = Random().nextInt(900000) + 100000;
    print(randomNumber);
    String apiKey = "b0314083-177e-11ec-864e-e29d2b69142c";
    String templateId = "1607100000000088994";
    String header = "GUZTYA";
    String domain = "bulksms.greenadsglobal.com";
    String name = "Customer";
    String phone = widget.newUser.mobileNumber!;
    String message =
        "Dear $name, Welcome to Guzty!! Use OTP $randomNumber to verify and start the MBU registration process. Please do not share this with anyone.GUZTY ACCERONS PRIVATE LIMITED";
    String url =
        "http://$domain/SMS_API/sendsms.php?apikey=$apiKey&mobile=${widget.newUser.countryCode}$phone&sendername=$header&message=$message&routetype=1&tid=$templateId";
    final response = await http.get(Uri.parse(url)).then((value) {
      start = 30;
      startTimer();
      // Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OtpSignUpPage(
      //       otp: randomNumber.toString(),
      //       newUser: widget.newUser,
      //     ),
      //   ),
      // );
    });
    print(response);
    print(response?.body);
  }

  bool resend = false;
  _verifyOtp(String otp) async {
    print("heheh ${widget.otp} $otp");
    print("heheh ${widget.otp.runtimeType} ${otp.runtimeType}");
    if (widget.otp.toString() == otp) {
      await custumer(widget.newUser, ref);

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //     "Correct OTP...!",
      //     style: TextStyle(
      //         fontFamily: 'Poppins',
      //         color: Palette.whiteColor,
      //         fontWeight: FontWeight.w500,
      //         letterSpacing: 0.6),
      //   ),
      //   duration: Duration(seconds: 1),
      //   backgroundColor: Color(0xff1F1C50),
      // ));

      // final snackBar = SnackBar(
      //   backgroundColor: const Color(0xff1F1C50),
      //   content: Text(
      //     "Correct OTP...!",
      //     style: TextStyle(
      //         color: Palette.whiteColor,
      //         fontSize: MediaQuery.of(context).size.width * 0.0355,
      //         fontWeight: FontWeight.w500),
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      verificationComplete = false;
      final snackBar = SnackBar(
        backgroundColor: const Color(0xff1F1C50),
        content: Text(
          "Wrong OTP...!",
          style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.0355,
              fontWeight: FontWeight.w500),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            resend = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    // telephony.listenIncomingSms(
    //   onNewMessage: (tel.SmsMessage message) {
    //     print(message.address); //+977981******67, sender nubmer
    //     print(message.body); //Your OTP code is 34567
    //     print(message.date); //1659690242000, timestamp

    //     String sms = message.body.toString(); //get the message

    //     // if(message.address == "+977981******67"){
    //     //verify SMS is sent for OTP with sender number
    //     String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
    //     //prase code from the OTP sms
    //     otpbox.set(otpcode.split(""));

    //     //split otp code to list of number
    //     //and populate to otb boxes

    //     setState(() {
    //       //refresh UI
    //     });

    //     // }else{
    //     //     print("Normal message.");
    //     // }
    //   },
    //   listenInBackground: false,
    // );
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm OTP',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, fontSize: width * 0.04),
                    ),
                    Text("Enter OTP That We Have Sent To Your  Phone number",
                        style: GoogleFonts.montserrat(
                          fontSize: width * 0.02,
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),

              // SizedBox(
              //   height: h * 0.03,
              // ),

              Pinput(
                // controller: pinController,
                onTap: () {},
                onCompleted: (value) {
                  _verifyOtp(value);
                },
                focusedPinTheme: PinTheme(
                    height: height * 0.06,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        color:
                            Pallete.primaryColor, border: Border.all(
                          color: Pallete
                              .primaryColor, // Set the desired border color here
                          width: 1.0, // Set the desired border width here
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 1,
                            blurRadius: 5,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8))),
                // controller: otp,
                defaultPinTheme: PinTheme(
                    height: height * 0.06,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        color: const Color(0xffebebeb),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 1,
                            blurRadius: 5,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8))),
                length: 6,
              ),
              // OTPTextField(
              //   controller: otpbox,
              //   length: 6,
              //   width: MediaQuery.of(context).size.width,
              //   fieldWidth: 50,
              //   style: const TextStyle(fontSize: 17),
              //   textFieldAlignment: MainAxisAlignment.spaceAround,
              //   fieldStyle: FieldStyle.box,
              //   onCompleted: (pin) {
              //     _verifyOtp(pin);
              //   },
              // ),
              SizedBox(
                height: height * 0.09,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Time Remaining ',
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11)),
                          TextSpan(
                              text: ' 00:$start',
                              style: GoogleFonts.montserrat(
                                  color: Pallete.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11)),
                          TextSpan(
                              text: ' s',
                              style: GoogleFonts.montserrat(
                                  color: Pallete.primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ])),
                    if (resend)
                      GestureDetector(
                        onTap: () {
                          if (resend) {
                            resend = false;
                            resetOtp();
                          }
                        },
                        child: Text(
                          "Resend",
                          style: GoogleFonts.montserrat(
                              color: Pallete.primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  custumer(UserModel customer, WidgetRef ref) async {
    // var settings = await ref.read(getSettingsProvider.future);
    // var id = settings.userId;
    var id = '';
    FirebaseFirestore.instance
        .collection("settings")
        .doc("settings")
        .update({"userId": FieldValue.increment(1)});

    FirebaseFirestore.instance
        .collection('user')
        .doc("GZU$id")
        .set(customer
        .copyWith(
        otp: int.tryParse(widget.otp) ?? 762438,
        otpUpdate: DateTime.now(),
        uid: "$id").toMap()
        // uid: "$id").toJson()
    )
        .then((value) async {
      userDataBox!.put("Uid", "GZU$id");
      FirebaseFirestore.instance
          .collection('user')
          .doc("GZU$id")
          .snapshots()
          .listen((event) {
        customerData = UserModel.fromMap(event.data() as Map<String, dynamic>);
        var userNotifier = ref.watch(userProvider.notifier);
        // userNotifier.updateUser(customerData!);
      });

      FirebaseFirestore.instance
          .collection("shippingAddress")
          .doc("GZU$id")
          .set({"address": [], "userId": "GZU$id"}).then((value) {
        getUser("GZU$id");
      });
      String? token = await FirebaseMessaging.instance.getToken();

      FirebaseFirestore.instance.collection('user').doc("GZU$id").update({
        'token': FieldValue.arrayUnion([token])
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageWidget(),
          ),
              (route) => false);
    });
  }

  getUser(String userdoc) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(userdoc)
        .snapshots()
        .listen((event) {
      if (event.exists && event.data()!.isNotEmpty) {
        userList = [];
        customerData = UserModel.fromMap(event.data() as Map<String, dynamic>);

        if (mounted) {
          setState(() {});
        }
      }
    });
  }
}