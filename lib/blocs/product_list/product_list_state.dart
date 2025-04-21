import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  const ProductListLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductListError extends ProductListState {
  final String error;

  const ProductListError(this.error);

  @override
  List<Object> get props => [error];
}
