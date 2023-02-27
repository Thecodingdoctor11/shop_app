import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontFamily: 'Anton', fontSize: 18),
            ),
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color.fromARGB(197, 255, 62, 62),
              onPrimary: Color.fromRGBO(219, 219, 219, 0.773),
              secondary: Color.fromARGB(197, 255, 62, 62),
              onSecondary: Color.fromRGBO(219, 219, 219, 0.773),
              error: Color.fromARGB(197, 248, 104, 37),
              onError: Color.fromRGBO(219, 219, 219, 0.773),
              background: Color.fromARGB(197, 187, 207, 236),
              onBackground: Color.fromRGBO(219, 219, 219, 0.773),
              surface: Color.fromARGB(243, 114, 9, 9),
              onSurface: Color.fromARGB(197, 255, 255, 255),
            ),
          ),
          home: const ProductOverviewScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
          }),
    );
  }
}
