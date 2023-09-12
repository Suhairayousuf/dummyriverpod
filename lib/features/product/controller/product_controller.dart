import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';
import '../repository/product_repository.dart';


// final productControllerProvider=
// AutoDisposeNotifierProvider<ProductController,bool>(() => ProductController(productRepository: ProductRepository));

final productControllerProvider = StateNotifierProvider((ref) {
  return ProductController(productRepository: ref.watch(productRepositoryProvider), ref: ref);
});


final getProductStreamProvider= StreamProvider.autoDispose((ref) {
  final getRepproduct=ref.watch(productControllerProvider.notifier);
  return getRepproduct.getProduct();
} );

class ProductController  extends StateNotifier<bool>{
  final ProductRepository _productRepository;
  final Ref _ref;

  ProductController({required ProductRepository productRepository,required Ref ref}): _productRepository=productRepository,_ref=ref, super(false);



  addProduct({required BuildContext context,required ProductModel productmodel }){
      // final repositoryData=ref.watch(productRepositoryProvider);
      _productRepository.addProduct(productmodel: productmodel);
      // final data= repositoryData.addProduct(productmodel: productmodel);


  }
  Stream<List<ProductModel>>getProduct(){
    return
      // ref.watch(productRepositoryProvider).getProducts();
    _productRepository.getProducts();
  }

  updateProduct({required BuildContext context,required ProductModel productmodel }){
    // final repositoryData=ref.watch(productRepositoryProvider);
    // final data= repositoryData.updateProduct(productmodel: productmodel);

    _productRepository.updateProduct(productmodel: productmodel);

  }
  deleteProduct({required BuildContext context,required ProductModel productmodel}){
    // final repositoryData=ref.watch(productRepositoryProvider);
    // final data= repositoryData.deleteProduct(productmodel: productmodel);
    _productRepository.deleteProduct(productmodel: productmodel);

  }
}