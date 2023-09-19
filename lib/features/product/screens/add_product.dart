import 'dart:io';

import 'package:dummyriverpod/features/product/screens/product_list.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/utils.dart';
import '../../../model/product_model.dart';
import '../../../theme/pallete.dart';
import '../controller/product_controller.dart';
class AddProducts extends ConsumerStatefulWidget {

  const AddProducts({Key? key, }) : super(key: key);

  @override
  ConsumerState<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  TextEditingController discription = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController percentage = TextEditingController();
  bool isStartingDateSelected = false;
  bool isEndingDateSelected = false;
  String startingdateInString = '';
  String endingdateInString = '';
  bool _isLoading = false;
  bool _switchValue = false;
  String photourl = '';
  File? image;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndtDate = DateTime.now();
  final picker = ImagePicker();

  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/${image!.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(image!);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      photourl = value;
      // showSnackBar(context, 'Upload Success',
      // );
    });
  }

  _pickImage() async {
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      image = File(imageFile!.path);
      uploadImageToFirebase(context);
      // showSnackBar(context, 'Uploading');
    });
  }
  addProduct(BuildContext context,ProductModel productmodel){
    ref.read(productControllerProvider.notifier).
    addProduct(context: context, productmodel: productmodel);

  }


  @override
  Widget build(BuildContext context) {

    print('rebuild');

    width = MediaQuery.of(context).size.width;
    DateTime date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS'),
        centerTitle: true,
        elevation: 0,
        backgroundColor:Pallete.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductList(
                    ),
                  ));
            },
            icon: Icon(CupertinoIcons.cart),
          ),
          SizedBox(
            width: width * 0.02,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: width * 0.07,
              ),

              Container(
                height: width * 0.17,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Pallete.primaryColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              Container(
                height: width * 0.17,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: amount,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Product price',
                      labelStyle: TextStyle(color:Pallete. primaryColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              SizedBox(
                height: width * 0.05,
              ),
              Container(
                height: width * 0.17,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: discription,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Product Discription',
                      labelStyle: TextStyle(color:Pallete. primaryColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Deal'),
              //     Switch(
              //       activeColor: primaryColor,
              //       value: _switchValue,
              //       onChanged: (value) {
              //         setState(() {
              //           _switchValue = value;
              //         });
              //       },
              //     ),
              //
              //   ],
              // ),
              // _switchValue==true?Container(
              //   height: width * 0.17,
              //   width: width * 0.9,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: primaryColor),
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(20),
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: TextFormField(
              //       controller: percentage,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         labelText: 'Offer %',
              //         labelStyle: TextStyle(color: primaryColor, fontSize: 20),
              //       ),
              //     ),
              //   ),
              // ):Container(),
              // SizedBox(
              //   height: width * 0.1,
              // ),
              Stack(clipBehavior: Clip.none, children: [
                InkWell(
                  onTap: () {
                    _pickImage();
                    // print(image);
                  },
                  child: image == null
                      ? Container(
                    width: width * 0.5,
                    height: width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallete.primaryColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(child: Text('Upload Image',style: GoogleFonts.poppins(
                        color:Pallete.primaryColor
                    ),)),
                  )
                      : Container(
                    width: width * 0.5,
                    height: width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(image!), fit: BoxFit.fitWidth),
                      border: Border.all(color: Pallete.primaryColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),

                  ),
                ),
                Positioned(
                  left: width * 0.43,
                  bottom: width * 0.43,
                  child: IconButton(
                    onPressed: () {
                      image = null;
                      setState(() {});
                    },
                    color:Pallete.primaryColor,
                    icon: Icon(
                      Icons.cancel,
                      size: width * 0.08,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: width * 0.08,
              ),
              InkWell(
                onTap: () {
                  print('photourl');
                  print(photourl);

                  if(
                  // selectedStartDate!=null&& selectedEndtDate!=null&&
                      photourl!=''&& name.text!=''&& discription.text!=''){
                    showDialog(context: context,
                        builder: (buildcontext)
                        {
                          print('ggggggggggggggg');

                          return AlertDialog(
                            title:  Text('Add Product',style:GoogleFonts.outfit() ,),
                            content:  Text('Do you want to Add?',style:GoogleFonts.outfit()),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(buildcontext);
                              },
                                  child:  Text('Cancel',style:GoogleFonts.outfit())),
                              TextButton(onPressed: () async {

                        final productData = ProductModel(
                        amount:double.tryParse(amount.text!.toString()),
                        createdDate:DateTime.now(),
                        image:photourl,
                        productName:name.text,
                        description: discription.text,
                        );
                        // await createProducts( productData,);
                        // await ref.read(productControllerProvider.notifier).
                        // addProduct(context: context, productmodel: productData);
                        addProduct(context, productData);

                        showSnackBar(context, 'Product added succesfully');
                        //   ,);
                        Navigator.pop(context);
                        Navigator.pop(buildcontext);

                        photourl='';
                        selectedEndtDate==null;
                        selectedStartDate==null;
                        // setState(() {
                        //
                        // });

                        // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
                        },
                        child: const Text('Yes')),                          ],
                          );

                        });

                  }
                  else{
                    // gender==''?showUploadMessage(context,'Please choose type',style: GoogleFonts.outfit()):
                    // selectedStartDate==''?showSnackBar(context,'Please select start date' ):
                    // selectedEndtDate==''?showSnackBar(context,'Please select end date'    ):
                    name.text ==''?showSnackBar(context,'Please Enter title of product'     ):
                    discription.text==''?showSnackBar(context,'Please Enter description'  ):
                    showSnackBar(context,'Please select an image ',                       );
                  }
                  // print(selectedStartDate);
                  // print(selectedEndtDate);
                  // if (selectedStartDate!='' && name.text != '') {
                  //   Offer.add({
                  //     'startingDate': selectedStartDate,
                  //     'endingDate': selectedEndtDate,
                  //     'offerName': name.text,
                  //     'discription': discription.text,
                  //     'photo': image,
                  //   });
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => OfferList(),
                  //       ));
                  // } else {
                  //   // Offer.clear();
                  //   print(Offer);
                  //   print(Offer.length);
                  // }

                },
                child: Container(
                  width: width * 0.8,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                      gradient:
                      LinearGradient(colors: [Pallete.primaryColor, Pallete.primaryColor]),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(
                      'Add Product',
                      style:
                      TextStyle(color: Colors.white, fontSize: width * 0.05),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // createProducts(ProductModel producData,) async {
  //
  //   FirebaseFirestore.instance.
  //   // collection('shops').doc(producData.shopId).
  //   collection('products').add(producData.toJson())
  //       .then((value) {
  //
  //     value.update({
  //       'id':value.id
  //     });
  //   });
  //
  // }
}
