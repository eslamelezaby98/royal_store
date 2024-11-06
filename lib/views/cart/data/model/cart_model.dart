import 'package:royal_store/views/product/data/model/product_model.dart';

class CartModel {
  final String id;
  final String userId;
  final ProductModel product;

  CartModel({
    required this.id,
    required this.userId,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'product': product,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      product: ProductModel.fromJson(map['productId']),
    );
  }
}
