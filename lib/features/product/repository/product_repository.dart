import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyriverpod/core/providers/firebase_providers.dart';
import 'package:dummyriverpod/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';

final productRepositoryProvider = Provider((ref) =>
    ProductRepository(firestore: ref.read(firestoreProvider)));

class ProductRepository {
  final FirebaseFirestore _firestore;
  ProductRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;


  CollectionReference get _products => _firestore.collection(FirebaseConstants.product);

  addProduct({required ProductModel productmodel}) {
    try {
      return right(
          _products.add(productmodel.toJson()).then((value) => value.update({
                'id': value.id,
              })));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }

    //   FirebaseFirestore.instance.collection(FirebaseConstants.product).
    //   add(productmodel.toJson()).then((value){
    //     value.update({
    //      'id':value.id,
    //     });
    //   });
  }

  Stream<List<ProductModel>> getProducts() {
    return _products
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromJson(e.data() as Map<String,dynamic>)).toList());
  }

  updateProduct({required ProductModel productmodel}) {
    try {
      return right(
          _products .doc(productmodel.id).update(productmodel.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
    // FirebaseFirestore.instance
    //     .collection(FirebaseConstants.product)
    //     .doc(productmodel.id)
    //     .update(productmodel.toJson());
  }

  deleteProduct({required ProductModel productmodel}) {
    try {
      return right(
          _products
              .doc(productmodel.id)
              .delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }

  }
}
