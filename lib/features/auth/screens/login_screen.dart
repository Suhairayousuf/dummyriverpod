import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummyriverpod/features/home/screen/home.dart';
import 'package:dummyriverpod/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/loader.dart';
import '../../../core/common/signin_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);


    return Scaffold(
      body:isLoading
          ? const Loader():Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

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