import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title; // Title of the product
  final double price; // Price of the product
  final String image; // Image path of the product
  final Color backgroundColor; // Background color of the card
  
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20), // Margin around the card
      padding: const EdgeInsets.all(16.0), // Padding inside the card
      decoration: BoxDecoration(
        color: backgroundColor, // Background color of the card
        borderRadius: BorderRadius.circular(20), // Rounded corners for the card
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          // Product title
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium, // Style for the product title
          ),
          const SizedBox(height: 5), // Space between title and price
          // Product price
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall, // Style for the product price
          ),
          const SizedBox(height: 5), // Space between price and image
          // Product image
          Center(
            child: Image.asset(
              image, // Image path
              height: 100, // Height of the image
            ),
          ),
        ],
      ),
    );
  }
}


