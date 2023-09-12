/*import 'package:customer/features/auth/screens/splash_screen/splash.dart';
import 'package:customer/theme/palette.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String randomNumber;
  const Otp({super.key, required this.randomNumber});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: w * 0.8,
                height: height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.02),
                  color: const Color.fromRGBO(159, 159, 159, 0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: height * 0.05,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(w * 0.02)),
                      child: Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.circular(w * 0.02)),
                      child: Center(
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.w700,
                              color: Palette.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: w * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: w * 0.04),
                    ),
                    Text(
                      "sign In quickly to manage orders",
                      style: TextStyle(
                        fontSize: w * 0.02,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffADADAD),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/features/auth/screens/splash_screen.dart';
// import 'package:customer/features/auth/screens/splash_screen/splash.dart';
// import 'package:customer/features/cart/screens/signup_for_guest.dart';
// import 'package:customer/features/home/screens/home.dart';
// import 'package:customer/models/costomer_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/utils/utils.dart';
import '../../../model/user_model.dart';
import '../../../theme/pallete.dart';
import '../controller/auth_controller.dart';

class OtpPage extends ConsumerStatefulWidget {
  var otp;
  // String apiKey;
  // String apiTemplate;
  bool login;
  String? phone;
  String? countryCode;
  // UserModel? vendor;
  OtpPage({
    super.key,
    required this.otp,
    // required this.apiKey,
    // required this.apiTemplate,
    required this.login,
    this.phone,
    this.countryCode,
    // this.vendor
  });
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  // Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  int start = 30;
  bool? verificationComplete;
  bool resend = false;
  void resetOtp() async {
    // int randomNumber = Random().nextInt(900000) + 100000;
    String randomNumber = widget.otp;
    if (kDebugMode) {
      print(randomNumber);
    }
    String apiKey = "b0314083-177e-11ec-864e-e29d2b69142c";
    String templateId = "1607100000000088994";
    String header = "GUZTYA";
    String domain = "bulksms.greenadsglobal.com";
    String name = "Customer";
    String phone = widget.phone!;
    String message =
        "Dear $name, Welcome to Guzty!! Use OTP $randomNumber to verify and start the MBU registration process. Please do not share this with anyone.GUZTY ACCERONS PRIVATE LIMITED";
    String url =
        "http://$domain/SMS_API/sendsms.php?apikey=$apiKey&mobile=${widget.countryCode}$phone&sendername=$header&message=$message&routetype=1&tid=$templateId";
    final response = await http.get(Uri.parse(url)).then((value) {
      start = 30;
      startTimer();
      // Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OtpPage(
      //       phone: widget.phone,
      //       login: true,
      //       otp: randomNumber.toString(),
      //     ),
      //   ),
      // );
    });
    if (kDebugMode) {
      print(response);
      print(response?.body);
    }
  }
  _verifyOtp(String otp) async {
    // var url = Uri.parse(
    //     'https://2factor.in/API/V1/${widget.apiKey}/SMS/VERIFY/${widget.otp}/$otp');
    // var response = await http.get(url);
    // print(response.body);
    // print("heheh ${widget.otp} $otp");
    // print("heheh ${widget.otp.runtimeType} ${otp.runtimeType}");
    if (widget.otp.toString() == otp) {
      verificationComplete = true;
      if (!widget.login) {
      } else {
        var data = await ref
            .watch(firestoreProvider)
            .collection(FirebaseConstants.usersCollection)
            .where('mobileNumber', isEqualTo: widget.phone)
            .get();

        if (data.docs.isNotEmpty) {
          var phoneNumber;

          // Iterate over the documents and find the matching document
          // for (var doc in data.docs) {
          // if (doc.get('mobileNumber') == widget.phone) {
          phoneNumber = data.docs.first.get('mobileNumber');
          currentUserId = data.docs.first.id;
          //   break; // Exit the loop once a matching document is found
          // }
          // }

          if (phoneNumber != null && currentUserId != null) {
            userDataBox?.put("uid", currentUserId);
            userDataBox?.put("phoneNumber", phoneNumber);
            String? token = await FirebaseMessaging.instance.getToken();

            FirebaseFirestore.instance.collection('user').doc(currentUserId).update({
              'token': FieldValue.arrayUnion([token])
            });

            FirebaseFirestore.instance
                .collection("user")
                .doc(currentUserId)
                .get()
                .then((value) {
              customerData =
                  UserModel.fromMap(value.data() as Map<String, dynamic>);
             // var userNotifier = ref.watch(userProvider.notifier);userNotifier.updateUser(customerData!);
            });
          } else {
            print('No  document found.');
          }
        } else {
          print('No phone number.');
        }
        Timer(const Duration(seconds: 1), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
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
      setState(() {});
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
    super.initState();
    // telephony.listenIncomingSms(
    //   onNewMessage: (SmsMessage message) {
    //     print(message.address); //+977981******67, sender nubmer
    //     print(message.body); //Your OTP code is 34567
    //     print(message.date); //1659690242000, timestamp
    //
    //     String sms = message.body.toString(); //get the message
    //
    //     // if(message.address == "+977981******67"){
    //     //verify SMS is sent for OTP with sender number
    //     String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
    //     //prase code from the OTP sms
    //     otpbox.set(otpcode.split(""));
    //
    //     //split otp code to list of number
    //     //and populate to otb boxes
    //
    //     setState(() {
    //       //refresh UI
    //     });
    //
    //     // }else{
    //     //     print("Normal message.");
    //     // }
    //   },
    //   listenInBackground: false,
    // );
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
                  SizedBox(height: width * 0.02),
                ],
              ),
            ),

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
                      color: const Color(0xffebebeb),
                      border: Border.all(
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
                  height: height * 0.08,
                  width: width * 0.13,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.shade100,
                      //     spreadRadius: 1,
                      //     blurRadius: 5,
                      //   )
                      // ],
                      borderRadius: BorderRadius.circular(8))),
              length: 6,
            ),
            // OTPTextField(
            //   controller: otpbox,
            //   length: 6,
            //   width: MediaQuery.of(context).size.width,
            //   fieldWidth: 50,
            //   style: TextStyle(fontSize: w * 0.05),
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
      ),
    );
  }
}