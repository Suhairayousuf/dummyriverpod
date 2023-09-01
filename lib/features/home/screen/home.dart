// import 'package:dummyriverpod/main.dart';
import 'dart:async';

import 'package:dummyriverpod/core/globals/local_variables.dart';
import 'package:dummyriverpod/features/auth/controller/auth_controller.dart';
import 'package:dummyriverpod/features/auth/screens/login_screen.dart';
import 'package:dummyriverpod/features/product/screens/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/utils.dart';
import '../../../theme/pallete.dart';
import '../../product/screens/add_product.dart';


double? lat;
double? long;
String currentPlace = '';
String administrativeArea = '';


class HomePageWidget extends ConsumerStatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends ConsumerState<HomePageWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Pallete.primaryColor,
        title: Center(child: Column(
          children: [
            Text('Home',style: TextStyle(fontFamily: 'Outfit'),),
            Text('version: 1.1',style: TextStyle(fontFamily: 'Outfit',fontSize: 9),),
          ],
        )),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right:18.0),
            child: InkWell(

                onTap: (){
                  showDialog(context: context,
                      builder: (buildcontext)
                      {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Do you want to Logout?'),
                          actions: [

                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                child: const Text('Cancel')),
                            TextButton(onPressed: ()async{
                              logout();                              // signOut(context);
                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);

                            },
                                child:  Text('Yes',style: TextStyle(
                                    color: Pallete.primaryColor
                                ),)),

                          ],
                        );

                      });

                },
                child: Icon(Icons.logout,color: Colors.white,size: 30,)),
          )

        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 50.0,left: 20,right: 20),
        child: Container(
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [

                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddProducts()));
                  },
                  child: Container(
                    height:100,
                    width: 100,
                    decoration: BoxDecoration( color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            maxRadius: 45,
                            backgroundColor:Pallete.primaryColor,
                            child: Image.asset('assets/images/Plus.png',color:Colors.white,height: 70,width: 70,)),
                        SizedBox(height: 10,),
                        Text('Add',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:Pallete.primaryColor),)
                      ],
                    ),

                  ),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => EditProduct()));
                  },
                  child: Container(
                    height:100,
                    width: 100,
                    decoration: BoxDecoration( color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            maxRadius: 45,
                            backgroundColor:Pallete.primaryColor,
                            child: Image.asset('assets/images/Plus.png',color:Colors.white,height: 70,width: 70,)),
                        SizedBox(height: 10,),
                        Text('Update',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:Pallete.primaryColor),)
                      ],
                    ),

                  ),
                ),
                // InkWell(
                //   onTap: (){
                //     // Navigator.push(context,
                //     //     MaterialPageRoute(builder: (context) => SponseredAdsPage()));
                //   },
                //   child: Container(
                //     height:100,
                //     width: 100,
                //     decoration: BoxDecoration( color: Colors.white,
                //         borderRadius: BorderRadius.circular(10)
                //     ),
                //     child:  Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircleAvatar(
                //             maxRadius: 45,
                //             backgroundColor:Pallete.primaryColor,
                //             child: Image.asset('assets/images/Plus.png',color:Colors.white,height: 70,width: 70,)),
                //         SizedBox(height: 10,),
                //         Text('delete',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:Pallete.primaryColor),)
                //       ],
                //     ),
                //
                //   ),
                // ),
                // // InkWell(
                // //   onTap: (){
                // //     // Navigator.push(context,
                // //     //     MaterialPageRoute(builder: (context) => ShopHomePage()));
                // //   },
                // //   child: Container(
                // //     height:100,
                // //     width: 100,
                // //     decoration: BoxDecoration( color: Colors.white,
                // //         borderRadius: BorderRadius.circular(10)
                // //     ),
                // //     child:  Column(
                // //       mainAxisAlignment: MainAxisAlignment.center,
                // //       children: [
                // //         CircleAvatar(
                // //             maxRadius: 45,
                // //             backgroundColor:primaryColor,
                // //             child: Image.asset('assets/images/money-bag.png',color:Colors.white,height: 70,width: 70,)),
                // //         SizedBox(height: 10,),
                // //         Text('Chit',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:primaryColor),)
                // //       ],
                // //     ),
                // //
                // //   ),
                // // ),
                // // InkWell(
                // //   onTap: (){
                // //     // Navigator.push(context,
                // //     //     MaterialPageRoute(builder: (context) => BannerWidget()));
                // //   },
                // //   child: Container(
                // //     height:100,
                // //     width: 100,
                // //     decoration: BoxDecoration( color: Colors.white,
                // //         borderRadius: BorderRadius.circular(10)
                // //     ),
                // //     child:  Column(
                // //       mainAxisAlignment: MainAxisAlignment.center,
                // //       children: [
                // //         CircleAvatar(
                // //             maxRadius: 45,
                // //             backgroundColor:primaryColor,
                // //             child: Image.asset('assets/images/kurifunds.png',color:Colors.white,height: 70,width: 70,)),
                // //         SizedBox(height: 10,),
                // //         Text('Kuri fund',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:primaryColor),)
                // //       ],
                // //     ),
                // //
                // //   ),
                // // ),
                // InkWell(
                //   onTap: (){
                //     // Navigator.push(context,
                //     //     MaterialPageRoute(builder: (context) => IncomeCategoryPage()));
                //   },
                //   child: Container(
                //     height:100,
                //     width: 100,
                //     decoration: BoxDecoration( color: Colors.white,
                //         borderRadius: BorderRadius.circular(10)
                //     ),
                //     child:  Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircleAvatar(
                //             maxRadius: 45,
                //             backgroundColor:Pallete.primaryColor,
                //             child: Image.asset('assets/images/Plus.png',color:Colors.white,height: 70,width: 70,)),
                //         SizedBox(height: 10,),
                //         Text('Display',style: TextStyle(fontFamily: 'Outfit',fontSize: 25,fontWeight: FontWeight.bold,color:Pallete.primaryColor),)
                //       ],
                //     ),
                //
                //   ),
                // ),


              ]

          ),
        ),
      ),
    );
    // );
  }
  void logout()async{
    userDataBox?.delete('email');
    ref.read(authControllerProvider.notifier).logout();
  }
}


// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomePage extends ConsumerWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return Consumer(
//         builder: (context,ref,child) {
//           final name=ref.watch(nameProvider);
//           return Scaffold(
//           appBar: AppBar(
//             title: Text(name)
//           ),
//           body: Column(
//                 children: [
//                   Text(name),
//                 ],
//               ),
//
//         );
//       }
//     );
//


