import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/core/providers/firebase_providers.dart';
import 'package:dummyriverpod/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';

final productRepositoryProvider=Provider((ref) => ProductRepository());
class ProductRepository{

  addProduct({required BuildContext context,required ProductModel productmodel} ){
    FirebaseFirestore.instance.collection(FirebaseConstants.product).
    add(productmodel.toJson()).then((value){
      value.update({
       'id':value.id,
      });
    });
  }

 Stream<List<ProductModel>> getProducts(){
    return FirebaseFirestore.instance.collection(FirebaseConstants.product).snapshots().map((event) =>
        event.docs.map((e) => ProductModel.fromJson(e.data())).toList());

  }

  updateProduct({required BuildContext context,required ProductModel productmodel}){
    FirebaseFirestore.instance.collection(FirebaseConstants.product).doc(productmodel.id).
    update(productmodel.toJson());
  }
  deleteProduct({required BuildContext context,required ProductModel productmodel}){
    FirebaseFirestore.instance.collection(FirebaseConstants.product).doc(productmodel.id).
    delete();
  }



}