import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import '../../../model/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
     firestore: ref.read(firestoreProvider),
     auth: ref.read(authProvider),
     googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository{
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _auth;
  late final GoogleSignIn _googleSignIn;


  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle({
  required BuildContext context,
}) async {
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


  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

}
