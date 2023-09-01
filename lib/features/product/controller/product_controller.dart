import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';
import '../repository/product_repository.dart';


final productControllerProvider=
AutoDisposeNotifierProvider<ProductController,bool>(() => ProductController());

final getProductStreamProvider= StreamProvider.autoDispose((ref) {
  final getRepproduct=ref.watch(productControllerProvider.notifier);
  return getRepproduct.getProduct();
} );

class ProductController  extends AutoDisposeNotifier<bool>{
  @override
  bool build() {
    return false;
}

  addProduct({required BuildContext context,required ProductModel productmodel }){
      final repositoryData=ref.watch(productRepositoryProvider);
      final data= repositoryData.addProduct(context:context,productmodel: productmodel);


  }
  Stream<List<ProductModel>>getProduct(){
    return ref.watch(productRepositoryProvider).getProducts();
  }

  updateProduct({required BuildContext context,required ProductModel productmodel }){
    final repositoryData=ref.watch(productRepositoryProvider);
    final data= repositoryData.updateProduct(context:context,productmodel: productmodel);


  }
  deleteProduct({required BuildContext context,required ProductModel productmodel}){
    final repositoryData=ref.watch(productRepositoryProvider);
    final data= repositoryData.deleteProduct(context:context,productmodel: productmodel);
  }



}