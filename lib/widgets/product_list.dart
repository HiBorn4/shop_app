import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  final String searchQuery; // The search query to filter products
  const ProductList({super.key, required this.searchQuery});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // List of filter options
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata', 'Jordan'];
  late String selectedFilter; // Currently selected filter
  bool isLoading = true; // Loading state for simulating network delay

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0]; // Set default filter to 'All'
    
    // Simulate a network call with a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Update loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter products based on the search query and selected filter
    List<Map<String, dynamic>> filteredProducts = products
        .where((product) {
          final productTitle = product['title'] as String;
          // Check if product matches the selected filter and search query
          final filter = selectedFilter == 'All' || product['company'] == selectedFilter;
          final searchMatch = productTitle.toLowerCase().contains(widget.searchQuery.toLowerCase());
          return filter && searchMatch;
        })
        .toList();

    return SafeArea(
      child: Column(
        children: [
          // Horizontal list view for filter options
          SizedBox(
            height: 50, // Height of the filter bar
            child: ListView.builder(
              itemCount: filters.length, // Number of filter options
              scrollDirection: Axis.horizontal, // Scroll direction is horizontal
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Material(
                    elevation: selectedFilter == filter ? 5 : 0, // Add shadow for selected filter
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary // Highlight selected filter
                            : const Color.fromRGBO(245, 247, 249, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter; // Update the selected filter
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Text(
                              filter,
                              style: TextStyle(
                                color: selectedFilter == filter
                                    ? Colors.white // Text color for selected filter
                                    : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) // Show loading spinner while data is loading
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Check if the screen width is greater than 1080 pixels
                      if (constraints.maxWidth > 1080) {
                        // Display products in a grid view for larger screens
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            childAspectRatio: 1.75, // Aspect ratio of each grid item
                            crossAxisSpacing: 8, // Horizontal space between grid items
                            mainAxisSpacing: 8, // Vertical space between grid items
                          ),
                          itemCount: filteredProducts.length, // Number of products to display
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsPage(
                                        product: product.cast<String, Object>(), // Pass product details to the details page
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ProductCard(
                                title: product['title'] as String,
                                price: product['price'] as double,
                                image: product['imageUrl'] as String,
                                backgroundColor: index.isEven
                                    ? const Color.fromRGBO(216, 240, 253, 1) // Alternate background color
                                    : const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            );
                          },
                        );
                      } else {
                        // Display products in a list view for smaller screens
                        return ListView.builder(
                          itemCount: filteredProducts.length, // Number of products to display
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsPage(
                                        product: product.cast<String, Object>(), // Pass product details to the details page
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ProductCard(
                                title: product['title'] as String,
                                price: product['price'] as double,
                                image: product['imageUrl'] as String,
                                backgroundColor: index.isEven
                                    ? const Color.fromRGBO(216, 240, 253, 1) // Alternate background color
                                    : const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


