import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime date;

  OrderItem(
      {required this.id,
      required this.date,
      required this.price,
      required this.products});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now.toString(),
          date: DateTime.now(),
          price: total,
          products: cartProducts),
    );
    notifyListeners();
  }
}
