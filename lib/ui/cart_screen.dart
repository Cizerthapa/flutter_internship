import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/blocs/cart/cart_event.dart';
import 'package:intern_app/blocs/cart/cart_state.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final CartItem cartItem = state.items[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      cartItem.product.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(cartItem.product.title),
                  subtitle: Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)} x ${cartItem.quantity}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          context.read<CartBloc>().add(
                            RemoveFromCart(cartItem.product),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implement checkout logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Checkout functionality not implemented',
                          ),
                        ),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
