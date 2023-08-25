import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/features/product/screens/update_product.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/utils.dart';
import '../../../model/product_model.dart';
import '../../../theme/pallete.dart';

class ProductList extends StatefulWidget {
  final String shopId;
  final String currencyShort;
  const ProductList({Key? key, required this.shopId, required this.currencyShort}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel>products=[];

  getProducts(){
    FirebaseFirestore.instance
        .collection('products').snapshots().listen((event) {
      products=[];
      for(var doc in event.docs){
        products.add(ProductModel.fromJson(doc.data()));
      }
      if(mounted){
        setState(() {

        });
      }

    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
         backgroundColor: Colors.white,
        title: Text('PRODUCT LIST',style: TextStyle(color: Pallete.primaryColor),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:  products.length==0?Center(
        child: Container(
          child: Text('No products found',style: GoogleFonts.outfit(color:Pallete. primaryColor),),
        ),
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: height,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ProductModel data=products[index];
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProducts(
                                 data:data
                              ),
                            ),
                          );
                        },
                        onLongPress: (){
                          showDialog(context: context, builder:(buildcontext)
                          {
                            return AlertDialog(
                              title: Text('Delete',style: GoogleFonts.outfit(),),
                              content: Text('Are you sure?',style: GoogleFonts.outfit()),
                              actions: [
                                TextButton(onPressed: () {

                                  Navigator.pop(context);
                                },
                                    child: Text('Cancel',style: GoogleFonts.outfit())),
                                TextButton(onPressed: ()  {
                                  FirebaseFirestore.instance.collection('shops').
                                  // doc(currentUserId).collection('offers').
                                  doc(data.id).delete();

                                  Navigator.pop(context);
                                  showSnackBar(context, "Deleted",);
                                },

                                    child: Text('Delete',style: GoogleFonts.outfit())),

                              ],
                            );
                          });
                        },
                        child: Container(
                            width: width * 0.95,
                            decoration: BoxDecoration(
                                border: Border.all(color:Pallete. primaryColor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Container(
                                  height: width * 0.45,
                                  // width: width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                  ),
                                  child:CachedNetworkImage( imageUrl: data.image.toString(),),

                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: width * 0.03,
                                    ),
                                    Text(
                                      data.productName.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Pallete.primaryColor,
                                          fontSize: width * 0.055,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: width * 0.03,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     // Text(
                                    //     //   DateFormat('dd/MM/yyyy').format(data.startDate!),
                                    //     //
                                    //     //   style:GoogleFonts.poppins(
                                    //     //       color: Pallete.primaryColor,
                                    //     //       fontSize: width * 0.03,
                                    //     //       fontWeight: FontWeight.w500),
                                    //     // ),
                                    //     Text(
                                    //       '-',
                                    //
                                    //       style: GoogleFonts.poppins(
                                    //           color: Pallete.primaryColor,
                                    //           fontSize: width * 0.03,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //     Text(
                                    //       DateFormat('dd/MM/yyyy').format(data.endDate!),
                                    //
                                    //       style: GoogleFonts.poppins(
                                    //           color: Pallete.primaryColor,
                                    //           fontSize: width * 0.03,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Text(
                                    //  widget.currencyShort+' '+ data.amount.toString(),
                                    //   style: GoogleFonts.poppins(
                                    //       color: primaryColor,
                                    //       fontSize: width * 0.055,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                    // SizedBox(
                                    //   height: width * 0.03,
                                    // ),
                                    data.description==''
                                        ? SizedBox()
                                        : Container(
                                        width: width * 0.45,

                                        child: Text(
                                          data.description.toString(),
                                          style: GoogleFonts.poppins(
                                            color: Pallete.primaryColor,
                                            fontSize: width * 0.025,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ))),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}