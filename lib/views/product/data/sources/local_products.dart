import 'dart:convert';
import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/expentions.dart';
import 'package:royal_store/views/product/data/model/product_model.dart';

class LocalProducts {
  final CacheHelper cacheHelper;
  LocalProducts({required this.cacheHelper});

  var key = "productCache";

  Future<void> cacheProducts(List<ProductModel>? products) async {
    if (products != null) {
      final List<String> cachedProducts =
          products.map((p) => json.encode(p.toJson())).toList();
      await cacheHelper.saveList(key: key, value: cachedProducts);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  List<ProductModel> getCachedProducts() {
    final jsonString = cacheHelper.getList(key);
    if (jsonString != null) {
      return jsonString
          .map((p) => ProductModel.fromJson(json.decode(p)))
          .toList();
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
}
