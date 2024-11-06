import 'package:flutter/material.dart';
import 'package:royal_store/views/cart/data/model/cart_model.dart';

import '../../domain/repo/cart_repo.dart';

class CartController with ChangeNotifier {
  final CartRepository _cartRepository;
  List<CartModel> _cartItems = [];
  
  CartController(this._cartRepository);

  List<CartModel> get cartItems => _cartItems;

  Future<void> addToCart(CartModel cartItem) async {
    await _cartRepository.addToCart(cartItem);
    _cartItems.add(cartItem);
    notifyListeners();
  }

  Future<void> fetchCartItems() async {
    _cartItems = await _cartRepository.getCartItems();
    notifyListeners();
  }
}
