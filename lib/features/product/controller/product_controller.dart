import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';
import '../repository/product_repository.dart';


final productControllerProvider=
StateNotifierProvider<ProductController,bool>((ref) => ProductController(ref: ref));

class ProductController  extends StateNotifier<bool>{
  final Ref ref;
  ProductController({required this.ref}):super(false);
  addProduct({required BuildContext context,required ProductModel productmodel }){
    final repositoryData=ref.watch(productRepositoryProvider);
   final data= repositoryData.addProduct(context:context,productmodel: productmodel);
  }


}