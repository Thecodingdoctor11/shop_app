import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './helpers/custom_route.dart';
import './providers/auth.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/auth_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (ctx, auth, previousProducts) => ProductsProvider(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
            create: (_) => ProductsProvider('', '', []),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousProducts) => Orders(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.orders),
            create: (_) => Orders('', '', []),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }),
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
              home: auth.isAuth
                  ? const ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen()),
              debugShowCheckedModeBanner: false,
              routes: {
                ProductDetailsScreen.routeName: (context) =>
                    const ProductDetailsScreen(),
                CartScreen.routeName: (context) => const CartScreen(),
                OrdersScreen.routeName: (context) => const OrdersScreen(),
                UserProductsScreen.routeName: (context) =>
                    const UserProductsScreen(),
                EditProductSceen.routeName: (context) =>
                    const EditProductSceen(),
              }),
        ));
  }
}
