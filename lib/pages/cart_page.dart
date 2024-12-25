import 'package:flutter/material.dart';
import 'package:minimal_shop/components/my_button.dart';
import 'package:minimal_shop/models/product.dart';
import 'package:minimal_shop/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove item from cart method
  void removeItemFromCart(BuildContext context, Product product) {
    context.read<Shop>().removeFromCart(product);
  }

  // pay button pressed method
  void payButtonPressed(BuildContext context) {
    // Pay logic goes here
    // For now, you can display a simple dialog or print a message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment'),
        content: const Text('Payment successful!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get access to the cart
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cart Page'),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // cart list
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                // get individual item in cart
                final item = cart[index];

                // return as a cart tile UI
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => removeItemFromCart(context, item),
                  ),
                );
              },
            ),
          ),

          // pay button
          MyButton(
              onTap: () => payButtonPressed(context),
              child: const Text('PAY NOW'))
        ],
      ),
    );
  }
}
