import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the CartProvider instance to get the cart details
    final cartProvider = context.watch<CartProvider>();
    final cart = cartProvider.cart; // Get the list of items in the cart

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'), // Title of the AppBar
      ),
      body: Column(
        children: [
          // Display total items and total price
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items: ${cartProvider.totalItems}', // Display the total number of items
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}', // Display the total price, formatted to 2 decimal places
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length, // Number of items in the cart
              itemBuilder: (context, index) {
                final cartItem = cart[index]; // Get the cart item at the current index

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(cartItem['imageUrl'] as String), // Display product image
                    radius: 30, // Radius of the CircleAvatar
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // Show a dialog to confirm the deletion of the product
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Product',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                              'Are you sure you want to remove the product from your cart?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog without deleting
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(cartItem); // Remove the product from the cart
                                  Navigator.of(context).pop(); // Close the dialog after deletion
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red, // Color of the delete icon
                    ),
                  ),
                  title: Text(
                    cartItem['title'].toString(), // Display the product title
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Size: ${cartItem['size']}'), // Display the product size
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Decrease the quantity of the product
                              context.read<CartProvider>().updateQuantity(
                                  cartItem, cartItem['quantity'] - 1);
                            },
                            icon: const Icon(Icons.remove), // Icon to decrease quantity
                          ),
                          Text(cartItem['quantity'].toString()), // Display the current quantity
                          IconButton(
                            onPressed: () {
                              // Increase the quantity of the product
                              context.read<CartProvider>().updateQuantity(
                                  cartItem, cartItem['quantity'] + 1);
                            },
                            icon: const Icon(Icons.add), // Icon to increase quantity
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


