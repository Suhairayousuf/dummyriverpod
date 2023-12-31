import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/core/constants/firebase_constants.dart';
import 'package:dummyriverpod/core/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/utils/utils.dart';
import '../../../model/user_model.dart';
import '../../home/screen/home.dart';
import '../repository/auth_repository.dart';


final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
      (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider), ref: ref,),);


final firebaseAuthProvider = Provider<FirebaseAuth>((ref)  {
  return FirebaseAuth.instance;
});
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref,})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); // loading

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context,) async {
    state = true;
    print("0");
    final user = await _authRepository.signInWithGoogle(context: context);

    state = false;
    user.fold(

          (l) => showSnackBar(context, l.message),


          (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),

    );
    Navigator.push(context,
         MaterialPageRoute(builder: (context) => HomePageWidget()));
  }



  Future<void> signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
    try {
      await _authRepository.signInWithPhoneNumber(phoneNumber,context);
    } catch (e) {
      // Handle error, e.g., show a snackbar with the error message
      print(e.toString());
    }

  }
  Future<void>otpVerification(String verId, String otpText,String phNo, BuildContext context)async {
    try {
      await _authRepository.otpVerification( verId,  otpText,phNo,context);
    } catch (e) {
      // Handle error, e.g., show a snackbar with the error message
      print(e.toString());
    }
  }

  //Stream<User?> get userStream => _users.doc() .data?.value?.userChanges() ?? const Stream.empty();
  // void signInAsGuest(BuildContext context) async {
  //   state = true;
  //   final user = await _authRepository.signInAsGuest();
  //   state = false;
  //   user.fold(
  //         (l) => showSnackBar(context, l.message),
  //         (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
  //   );
  // }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    _authRepository.logOut();
  }

  CollectionReference get _users=>_ref.read(firestoreProvider).collection(FirebaseConstants.usersCollection);
}