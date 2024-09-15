import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // Private list to store cart items
  final List<Map<String, dynamic>> _cart = [];

  // Public getter for cart items
  List<Map<String, dynamic>> get cart => _cart;

  // Add a product to the cart
  void addProduct(Map<String, dynamic> product) {
    // Find an existing product in the cart with the same ID and size
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'] && item['size'] == product['size'],
      orElse: () => {}, // Return an empty map if not found
    );

    // If the product already exists in the cart, increment its quantity
    if (existingProduct.isNotEmpty) {
      existingProduct['quantity'] += 1;
    } else {
      // If the product is not in the cart, set its quantity to 1 and add it
      product['quantity'] = 1;
      _cart.add(product);
    }
    // Notify listeners to update UI
    notifyListeners();
  }

  // Remove a product from the cart
  void removeProduct(Map<String, dynamic> product) {
    _cart.remove(product); // Remove the product from the cart
    // Notify listeners to update UI
    notifyListeners();
  }

  // Update the quantity of a product in the cart
  void updateQuantity(Map<String, dynamic> product, int newQuantity) {
    // Find the existing product in the cart with the same ID and size
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'] && item['size'] == product['size'],
      orElse: () => {}, // Return an empty map if not found
    );

    // If the product is found, update its quantity or remove it if the new quantity is zero
    if (existingProduct.isNotEmpty) {
      if (newQuantity > 0) {
        existingProduct['quantity'] = newQuantity;
      } else {
        _cart.remove(existingProduct); // Remove the product if quantity is zero or less
      }
      // Notify listeners to update UI
      notifyListeners();
    }
  }

  // Get the total number of items in the cart
  int get totalItems {
    // Sum up the quantity of each item in the cart
    return _cart.fold(0, (sum, item) => sum + (item['quantity'] as int ));
  }

  // Get the total price of all items in the cart
  double get totalPrice {
    // Sum up the total price of each item (price * quantity) in the cart
    return _cart.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}


