import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_app/blocs/product_list/product_list_event.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/product_list/product_list_bloc.dart';
import '../../services/product_service.dart';
import '../../ui/product_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductService>(create: (_) => ProductService()),
        BlocProvider<ProductListBloc>(
          create:
              (context) => ProductListBloc(
                Provider.of<ProductService>(context, listen: false),
              )..add(LoadProducts()),
        ),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Product Cart App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ProductListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
