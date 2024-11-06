
import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import 'package:royal_store/views/product/data/model/product_model.dart';
import '../../domain/repo/product_repo.dart';
import '../sources/local_products.dart';
import '../sources/remote_product.dart';
import '../sources/search_products.dart';

class ProductRepoImp extends ProductRepo {
  final NetworkInfo networkInfo;
  final RemoteProducts remoteProducts;
  final LocalProducts localProducts;
  final SearchProduct searchProducts;

  ProductRepoImp({
    required this.networkInfo,
    required this.remoteProducts,
    required this.localProducts,
    required this.searchProducts,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    if (await networkInfo.isConnected!) {
      try {
        var productsList = await remoteProducts.getProducts();
        localProducts.cacheProducts(productsList);
        return productsList;
      } on ServerException catch (e) {
        throw Failure(errMessage: e.errorModel.errorMessage);
      }
    } else {
      try {
        var products = localProducts.getCachedProducts();
        return products;
      } on CacheExeption catch (e) {
        throw Failure(errMessage: e.errorMessage);
      }
    }
  }

  @override
  List<ProductModel> searchProduct(List<ProductModel> value, String text) {
    return searchProducts.getSearchedProducts(value, text);
  }
}
