import '../../data/model/cart_model.dart';

abstract class CartRepository {
  Future<void> addToCart(CartModel cartItem);
  Future<List<CartModel>> getCartItems();
}
