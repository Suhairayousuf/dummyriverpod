import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/theme/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../core/globals/local_variables.dart';
import '../../../core/utils/utils.dart';
import 'splash_screen.dart';
import 'login_screen.dart';




class OtpPage extends StatefulWidget {
  final String verId;
  final String number;
  final String code;

  const OtpPage({
    Key? key,
    required this.verId,
    required this.number,
    required this.code,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();
  TextEditingController otp = TextEditingController();
  List phList=[];
// Future<void> otpVerification() async {
//   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: widget.verId, smsCode: otp.text);
//   await auth.signInWithCredential(credential).then((value) async {
//     print(value.user!.uid);
//     _btnController1.reset();
//     // currentUserPhone=widget.number;
//      currentUserId=value.user!.uid;
//     userDataBox?.put('uid', value.user!.uid??"" );
//     print('hereBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
//     print(currentUserId);
//
//     // Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //         builder: (context) => DetailsPage(
//     //           id: value.user!.uid,
//     //           phone: widget.number,
//     //           code:widget.code
//     //         )));
//     print(widget.number);
//     QuerySnapshot users=await FirebaseFirestore.instance.collection('users')
//         .where('phone',isEqualTo:widget.number ).get();
//     if(users.docs.isEmpty){
//       print('here2');
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => LoginScreen(
//
//               )));
//     }else{
//       print('here3');
//       // currentUserId=preferences.getString('userId')??"";
//
//       // SharedPreferences preferences= await SharedPreferences.getInstance();
//       // preferences.setString('userId',widget.updatedId);
//       // preferences.setString('userId',users.docs[0].get('userId'));
//       // // preferences.setString('icamaNumber',userDetails[1]['icamaNumber']);
//       // preferences.setString('userEmail',users.docs[0].get('userEmail'));
//       // preferences.setString('phone',users.docs[0].get('phone'));
//       // currentUserId=preferences.getString('userId')??"";
//       // // currentIcama=preferences.getString('icamaNumber')??"";
//       // currentUserEmail=preferences.getString('userEmail')??"";
//       // getcurrentuser();
//
//       Navigator.pushAndRemoveUntil(
//           context, MaterialPageRoute(builder: (context)=>Splash()), (route) => false);
//     }
//
//     print(widget.number);
//
//     print(widget.code);
//
//
//   }
//   ).catchError((e) {
//     print(e);
//     _btnController1.reset();
//     // showSnackbar(context, 'Wrong OTP!!');
//   });
// }
  @override
  void initState() {
    // TODO: implement initState
    _btnController1.stateStream.listen((value) {
      print(value);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor:Pallete.primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:Pallete.primaryColor,
          elevation: 0,

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.008,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Send OTP ",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.08),
                    ),
                    // SizedBox(
                    //   height: height * 0.008,
                    // ),
                    Text(
                      "Enter your OTP number send to*****  ${widget.number.substring(5,widget.number.length)}",
                      // "",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.03),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    // Text(
                    //   "Enter the OTP below to verify your number",
                    //   style:  GoogleFonts.poppins(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: width * 0.035,
                    //       color: Color(0xff000000).withOpacity(0.5)),
                    // ),
                  ],
                ),
                SizedBox(
                  height: height * 0.048,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.018),
                  child: Pinput(
                    controller: otp,
                    defaultPinTheme: PinTheme(
                        height: height * 0.06,
                        width: width * 0.12,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Pallete.primaryColor,
                          borderRadius: BorderRadius.circular(8),

                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                        )

                    ),
                    length: 6,
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: width*0.05),
                  child: Center(
                    child: Text(
                      "Resend OTP",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.03),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.1,
                ),
                RoundedLoadingButton(
                  successIcon: Icons.check,
                  failedIcon: Icons.close,
                  color: Colors.white,
                  valueColor: Pallete.primaryColor,
                  child:  Text("CONTINUE", style: GoogleFonts.poppins(color: Pallete.primaryColor,
                      fontWeight: FontWeight.w600,fontSize: 19
                  )),
                  controller: _btnController1,
                  onPressed: () async {
                    //ref.read(authControllerProvider.notifier).otpVerification( widget.verId,otp.text,widget.number,context);
                    print('here');

                  },
                ),
                Text("v.1.0.0",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff6E788E),
                    )),

                // GestureDetector(
                //   onTap: () async {
                //
                //   },
                //   child: Padding(
                //     padding:  EdgeInsets.fromLTRB(width*0.05,0,0,0),
                //     child: Container(
                //       height: height * 0.06,
                //       width: width * 0.76,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(35),
                //       ),
                //       child: Center(
                //         child: Text("CONTINUE", style: GoogleFonts.poppins(color: primarycolor,
                //           fontWeight: FontWeight.w600,fontSize: 19
                //         )),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: width*0.05),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Entered wrong number?",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: width * 0.03),
                        ),
                        Text(
                          "Re-enter number",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: width * 0.03),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


