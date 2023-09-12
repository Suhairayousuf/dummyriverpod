import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/features/auth/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../model/user_model.dart';
import '../screens/splash_screen.dart';
import '../screens/otp_page.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
     firestore: ref.read(firestoreProvider),
     auth: ref.read(authProvider),
     googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository{
  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();
   final FirebaseFirestore _firestore;
   final FirebaseAuth _auth;
   final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;
  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle({required BuildContext context,}) async {
    try {
      print("2");
      UserCredential userCredential;
      // if (kIsWeb) {
      //   GoogleAuthProvider googleProvider = GoogleAuthProvider();
      //   googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      //   userCredential = await _auth.signInWithPopup(googleProvider);
      // } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        final googleAuth = await googleUser?.authentication;
        print("3");
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
          userCredential = await _auth.signInWithCredential(credential);
          print("4");
          print(userCredential);

          //userCredential = await _auth.currentUser!.linkWithCredential(credential);

      // }

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          profilePic: userCredential.user!.photoURL ?? '',
          email: userCredential.user!.email??"" ,
          uid: userCredential.user!.uid,
          mobileNumber: '', countryCode: '', otp: 0000, otpUpdate: DateTime.now(),

        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userDataBox?.put('email', userCredential.user!.email??"" );
        userDataBox?.put('uid', userCredential.user!.uid??"" );
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }

  }
  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }


Future<User?> signInWithPhoneNumber(String phoneNumber,BuildContext context) async {
    String verificationId='';
     try {
       await _auth.verifyPhoneNumber(

         phoneNumber: phoneNumber,
         verificationCompleted: (PhoneAuthCredential credential) async {
           await _auth.signInWithCredential(credential);
         },
         verificationFailed: (FirebaseAuthException e) {
           throw e;
         },
         codeSent: (String verificationId, int? resendToken) {
           verificationId = verificationId;

           Navigator.pushReplacement(
             context,
             MaterialPageRoute(
                 builder: (context) => OtpPage(
                     verId: verificationId,
                     number: phoneNumber,
                     code: '+91')),
           );
           // Handle code sent, e.g., show an OTP input field
         },
         codeAutoRetrievalTimeout: (String verificationId) {
           _btnController1.reset();
           verificationId = verificationId;
           // Handle timeout
         },

       );


     } catch (e) {
       throw e;
     }
     // Navigator.pushReplacement(
     //   context,
     //   MaterialPageRoute(
     //       builder: (context) => OtpPage(
     //           verId: verificationId,
     //           number: phoneNumber,
     //           code: '+91')),
     // );

   }
   void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
  Future<void> otpVerification(String verId, String otpText,String phNo, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId, smsCode:otpText);
    await _auth.signInWithCredential(credential).then((value) async {
      print(value.user!.uid);
      _btnController1.reset();
      // currentUserPhone=widget.number;
      currentUserId=value.user!.uid;
      userDataBox?.put('uid', value.user!.uid??"" );
      print('hereBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      print(currentUserId);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DetailsPage(
      //           id: value.user!.uid,
      //           phone: widget.number,
      //           code:widget.code
      //         )));
      QuerySnapshot users=await FirebaseFirestore.instance.collection('users')
          .where('phone',isEqualTo:phNo ).get();
      if(users.docs.isEmpty){
        print('here2');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(

                )));
      }else{
        print('here3');
        // currentUserId=preferences.getString('userId')??"";

        // SharedPreferences preferences= await SharedPreferences.getInstance();
        // preferences.setString('userId',widget.updatedId);
        // preferences.setString('userId',users.docs[0].get('userId'));
        // // preferences.setString('icamaNumber',userDetails[1]['icamaNumber']);
        // preferences.setString('userEmail',users.docs[0].get('userEmail'));
        // preferences.setString('phone',users.docs[0].get('phone'));
        // currentUserId=preferences.getString('userId')??"";
        // // currentIcama=preferences.getString('icamaNumber')??"";
        // currentUserEmail=preferences.getString('userEmail')??"";
        // getcurrentuser();

        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context)=>Splash()), (route) => false);
      }




    }
    ).catchError((e) {
      print(e);
      _btnController1.reset();
      // showSnackbar(context, 'Wrong OTP!!');
    });
  }
}
