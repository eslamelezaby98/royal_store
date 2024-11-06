import '../../../../core/databases/api/api_consumer.dart';
import 'package:royal_store/views/product/data/model/product_model.dart';

class RemoteProducts {
  final ApiConsumer apiConsumer;

  RemoteProducts({required this.apiConsumer});
  Future<List<ProductModel>> getProducts() async {
    var response = await apiConsumer.get("products");
    List<ProductModel> products = [];
    for (var element in response) {
      products.add(ProductModel.fromJson(element));
    }
    return products;
  }
}
