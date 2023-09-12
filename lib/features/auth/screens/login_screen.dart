import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummyriverpod/features/auth/screens/signup_page.dart';
import 'package:dummyriverpod/features/home/screen/home.dart';
import 'package:dummyriverpod/model/user_model.dart';
import 'package:dummyriverpod/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../core/common/loader.dart';
import '../../../core/common/signin_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../controller/auth_controller.dart';
import 'otp_page.dart';
String countryCodes='';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _phoneNumber = TextEditingController();
    String countryCode ='+91';
    final isLoading = ref.watch(authControllerProvider);
    final RoundedLoadingButtonController _btnController1 =
    RoundedLoadingButtonController();


    return Scaffold(
      body:isLoading
          ? const Loader():Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: width * 0.2,
          ),

          Padding(
            padding:  EdgeInsets.all(width*0.05),
            child: IntlPhoneField(
              // readOnly: true,
              style: TextStyle(color: Colors.black),
              dropdownTextStyle: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              controller: _phoneNumber,
              decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                iconColor: Colors.black,
                hintText: 'Enter your phone number...',
                hintStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                labelText: 'Phone Number',
                labelStyle: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.white,),

              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
                print("hiiiiiiiiiiiiiiiiiiiiiiiiiii");
                print(phone.countryISOCode);

                print(phone.countryCode);
                // countryCode = phone.countryCode;
                // _phoneNumber.text = phone.completeNumber;
                print(_phoneNumber.text);
              },
              onCountryChanged: (country) {
                countryCodes=country.code;
                print(countryCodes);
                print('Country changed to: ' + country.dialCode);

                countryCode = '+${country.dialCode}';
                print(1);
                print(countryCode);

              },
            ),

          ),

          RoundedLoadingButton(
              successIcon: Icons.check,
              failedIcon: Icons.close,
              color: Colors.white,
              valueColor: Pallete.primaryColor,
              child: Text(
                "Send OTP",
                style: TextStyle(
                  color:  Pallete.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              controller: _btnController1,
              onPressed: () {
                if (_phoneNumber.text != '') {
                   // verifyPhoneNumber(context);
                  ref.read(authControllerProvider.notifier).signInWithPhoneNumber('+91'+_phoneNumber.text,context);

                  // loading = true;
                  // setState(() {});
                } else {
                  showUploadMessage(
                      context, 'Enter your phone number',
                      style: GoogleFonts.poppins());
                }
              }),
          SizedBox(height: 20,),
          RoundedLoadingButton(
              successIcon: Icons.check,
              failedIcon: Icons.close,
              color: Colors.green,
              valueColor: Pallete.primaryColor,
              child: Text(
                "Send OTP",
                style: TextStyle(
                  color:  Pallete.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              controller: _btnController1,
              onPressed: () {
                if (_phoneNumber.text != '') {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpSignUpPage(
                  //   otp: '',
                  //   newUser: null,)));
                   // verifyPhoneNumber(context);
                  // ref.read(authControllerProvider.notifier).signInWithPhoneNumber('+91'+_phoneNumber.text,context);

                  // loading = true;
                  // setState(() {});
                } else {
                  showUploadMessage(
                      context, 'Enter your phone number',
                      style: GoogleFonts.poppins());
                }
              }),
          InkWell(
            onTap: () {
              ref.read(authControllerProvider.notifier).signInWithGoogle(context);
              // SignInButton();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomePageWidget()));
              // _auth.signInWithGoogle(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: width * 0.87,
                height: width * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          Constants.googleIcon),
                      backgroundColor: Pallete.primaryColor,
                    ),
                    Text(
                      'Continue with Google',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color:  Pallete.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/constants/constants.dart';
// import '../../../theme/pallete.dart';
// import '../controller/auth_controller.dart';
//
//
// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   // void signInAsGuest(WidgetRef ref, BuildContext context) {
//   //   ref.read(authControllerProvider.notifier).signInAsGuest(context);
//   // }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isLoading = ref.watch(authControllerProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title:  CircleAvatar(
//                       backgroundImage: CachedNetworkImageProvider(
//                           Constants.googleIcon),
//                       backgroundColor: Pallete.primaryColor,
//                     ),
//         actions: [
//           TextButton(
//             // onPressed: () => signInAsGuest(ref, context),
//             onPressed: () {},
//             child: const Text(
//               'Skip',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: isLoading
//           // ? const Loader()
//            ? CircularProgressIndicator()
//           : Column(
//         children: [
//           const SizedBox(height: 30),
//           const Text(
//             'Dive into anything',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 0.5,
//             ),
//           ),
//           const SizedBox(height: 30),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               Constants.googleIcon,
//               height: 400,
//             ),
//           ),
//           const SizedBox(height: 20),
//           // const Responsive(child: SignInButton()),
//         ],
//       ),
//     );
//   }
// }