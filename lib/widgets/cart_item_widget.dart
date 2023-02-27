import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {required this.price,
      required this.title,
      required this.quantity,
      required this.id,
      required this.productId,
      super.key});
  final String productId;
  final String id;
  final double price;
  final String title;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).colorScheme.surface,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Chip(
              backgroundColor: Theme.of(context).colorScheme.surface,
              label: Text('EGP $price'),
            ),
            title: Text(title),
            subtitle: Text('Total: EGP ${price * quantity}'),
            trailing: Text('x$quantity'),
          ),
        ),
      ),
    );
  }
}
