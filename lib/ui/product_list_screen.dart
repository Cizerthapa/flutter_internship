import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/blocs/cart/cart_event.dart';
import 'package:intern_app/blocs/product_list/product_list_state.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/product_list/product_list_bloc.dart';
import '../../../ui/cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        context.read<CartBloc>().add(AddToCart(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductListError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('Loading products...'));
          }
        },
      ),
    );
  }
}
