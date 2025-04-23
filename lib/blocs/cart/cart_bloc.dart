import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../models/cart_item.dart';

// CartBloc handles the business logic for managing the cart
class CartBloc extends Bloc<CartEvent, CartState> {
  // Constructor to initialize the bloc and set up event handlers
  CartBloc() : super(const CartState()) {
    // Handling the AddToCart event
    on<AddToCart>(_onAddToCart);
    // Handling the RemoveFromCart event
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  // Handler for adding items to the cart
  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    // Check if the product is already in the cart
    final existingItemIndex = state.items.indexWhere(
      (item) =>
          item.product.id == event.product.id, // Compare based on product ID
    );

    if (existingItemIndex >= 0) {
      // If the product is already in the cart, update its quantity
      final updatedItems = List<CartItem>.from(
        state.items,
      ); // Make a copy of the items
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1, // Increment the quantity by 1
      );
      emit(
        state.copyWith(items: updatedItems),
      ); // Emit the updated state with the new items list
    } else {
      // If the product is not in the cart, add it to the cart with quantity 1
      final updatedItems = [...state.items, CartItem(product: event.product)];
      emit(
        state.copyWith(items: updatedItems),
      ); // Emit the updated state with the new items list
    }
  }

  // Handler for removing items from the cart
  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    // Check if the product is in the cart
    final existingItemIndex = state.items.indexWhere(
      (item) =>
          item.product.id == event.product.id, // Compare based on product ID
    );

    if (existingItemIndex >= 0) {
      // If the product is found in the cart
      final updatedItems = List<CartItem>.from(
        state.items,
      ); // Make a copy of the items
      final existingItem = updatedItems[existingItemIndex];
      if (existingItem.quantity > 1) {
        // If quantity is greater than 1, decrement the quantity
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity - 1, // Decrement the quantity by 1
        );
      } else {
        // If quantity is 1, remove the product from the cart
        updatedItems.removeAt(existingItemIndex);
      }
      emit(
        state.copyWith(items: updatedItems),
      ); // Emit the updated state with the new items list
    }
  }
}
