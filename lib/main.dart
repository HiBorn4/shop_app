import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Provide multiple providers to the widget tree
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                CartProvider()), // Provide CartProvider to manage cart state
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hide the debug banner in the app
        title: 'Shopping App', // Set the title of the app
        theme: ThemeData(
          fontFamily: 'Lato', // Set default font for the app
          colorScheme: ColorScheme.fromSeed(
            seedColor:
                const Color.fromRGBO(254, 206, 1, 1), // Primary color seed
            primary: const Color.fromRGBO(
                254, 206, 1, 1), // Primary color of the app
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20, // Font size for the AppBar title
              color: Colors.black, // Color of the AppBar title text
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold, // Font weight for hint text
              fontSize: 16, // Font size for hint text
            ),
            prefixIconColor: Color.fromRGBO(
                119, 119, 119, 1), // Color for prefix icons in input fields
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold, // Font weight for large titles
              fontSize: 35, // Font size for large titles
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold, // Font weight for medium titles
              fontSize: 20, // Font size for medium titles
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold, // Font weight for small body text
              fontSize: 16, // Font size for small body text
            ),
          ),
          useMaterial3: true, // Enable Material Design 3
        ),
        home:
            const SplashScreen(), // Set SplashScreen as the home screen of the app
      ),
    );
  }
}
