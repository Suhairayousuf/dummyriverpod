import 'dart:async';

import 'package:dummyriverpod/core/globals/local_variables.dart';
import 'package:dummyriverpod/features/auth/screens/login_screen.dart';
import 'package:dummyriverpod/features/home/screen/home.dart';
import 'package:dummyriverpod/theme/pallete.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';

String userEmail='';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final Authentication _auth = Authentication();
  @override
  bool login=false;

  @override
  getValidation() async {

    // final localStorage= await SharedPreferences.getInstance();

    bool? log=userDataBox?.containsKey('email');
    if(log==true) {
      userEmail=userDataBox?.get('email')!;
      // if(shopAdmins.contains(currentShopUserEmail)){
      login=true;
      setState(() {

      });

    }

    setState(() {

    });


  }
  void initState() {
    getValidation();
    // getUserData();
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
          builder: (context)=>
          login?HomePageWidget( ):LoginScreen()), (route) => false);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context) =>SelectShopWidget( email:currentShopEmail) ,), (route) => false);


      // if(currentUserEmail!=null&& currentUserEmail!="" ){
      // }

      // }else{

      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginSelectPage()), (route) => false);
      // }
      //
      //
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: width*2.2,
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          color: Pallete.primaryColor,
        ),
      ),
    );
  }
}
