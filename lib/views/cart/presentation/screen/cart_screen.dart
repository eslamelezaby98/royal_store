import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_store/main.dart';
import 'package:royal_store/views/cart/presentation/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: const SizedBox(),
      ),
      body: FutureBuilder(
        future: cartProvider.fetchCartItems(currentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          cartItem.product.images.isEmpty
                              ? const Icon(Icons.error)
                              : Center(
                                  child: CachedNetworkImage(
                                    height: 80,
                                    width: 100,
                                    imageUrl: cartItem.product.images[0],
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.product.title,
                                ),
                                Text(
                                  cartItem.product.description,
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${cartItem.product.price}\$",
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
