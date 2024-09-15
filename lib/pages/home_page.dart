import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/widgets/product_list.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0; // Index of the currently displayed page
  String searchQuery = ''; // Search query for filtering products
  final TextEditingController _searchController = TextEditingController(); // Controller for managing search input

  // List of pages to be displayed
  final List<Widget> pages = [
    const ProductList(searchQuery: ''), // ProductList page initialized with an empty search query
    const CartPage(), // CartPage to display items in the cart
  ];

  // Handle page navigation change
  void _handleNavigationChange(int index) {
    setState(() {
      currentPage = index; // Update the current page index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'), // Title of the app bar
        actions: [
          AnimSearchBar(
            width: 350, // Width of the search bar
            textController: _searchController, // Controller for managing the search text
            onSuffixTap: () {
              setState(() {
                searchQuery = ''; // Clear the search query
                _searchController.clear(); // Clear the search bar text
                pages[0] = ProductList(
                    searchQuery: searchQuery); // Update ProductList with the cleared search query
              });
            },
            onSubmitted: (String value) {
              setState(() {
                searchQuery = value; // Update the search query with the submitted value
                pages[0] = ProductList(
                    searchQuery: searchQuery); // Update ProductList with the new search query
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage, // Display the page based on the current index
        children: pages, // List of pages to display
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            icon: Icons.home, // Icon for the home page
            extras: {"label": "Home"}, // Label for the home page icon
          ),
          FluidNavBarIcon(
            icon: Icons.shopping_cart, // Icon for the cart page
            extras: {"label": "Cart"}, // Label for the cart icon
          ),
        ],
        onChange: _handleNavigationChange, // Callback for handling navigation changes
        style: const FluidNavBarStyle(
          barBackgroundColor: Colors.white, // Background color of the navigation bar
          iconUnselectedForegroundColor: Colors.black54, // Color for unselected icons
          iconSelectedForegroundColor: Colors.black, // Color for selected icons
        ),
        scaleFactor: 1.5, // Scale factor for the icons
        defaultIndex: currentPage, // Default index of the navigation bar
      ),
    );
  }
}


