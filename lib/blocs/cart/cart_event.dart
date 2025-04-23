import 'package:equatable/equatable.dart';
import '../../models/product.dart';

// The base class for CartEvent that extends Equatable for value comparison
// This ensures that events are compared based on their properties, which helps in efficient state management
abstract class CartEvent extends Equatable {
  const CartEvent(); // Constructor for CartEvent

  // Overriding the Equatable's props getter to include the properties we want to compare
  @override
  List<Object> get props => [];
}

// Event for adding a product to the cart
class AddToCart extends CartEvent {
  final Product product; // The product that needs to be added to the cart

  // Constructor that takes the product to be added
  const AddToCart(this.product);

  // Overriding the props getter to include the product for comparison
  @override
  List<Object> get props => [product]; // Include product in the comparison for equality checks
}

// Event for removing a product from the cart
class RemoveFromCart extends CartEvent {
  final Product product; // product that needs to be removed from the cart

  // Constructor that takes the product to be removed
  const RemoveFromCart(this.product);

  // Overriding the props getter to include the product for comparison
  @override
  List<Object> get props => [product]; // Include product in the comparison for equality checks
}
