import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:royal_store/views/cart/data/model/cart_model.dart';

import '../../domain/repo/cart_repo.dart';

class FirebaseCartRepository implements CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToCart(CartModel cartItem) async {
    await _firestore.collection('cart').doc(cartItem.id).set(cartItem.toMap());
  }

  @override
  Future<List<CartModel>> getCartItems(String userId) async {
    final snapshot = await _firestore
        .collection('cart')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList();
  }
}
