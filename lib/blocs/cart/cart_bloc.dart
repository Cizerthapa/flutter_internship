import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingItemIndex = state.items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingItemIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      emit(state.copyWith(items: updatedItems));
    } else {
      final updatedItems = [...state.items, CartItem(product: event.product)];
      emit(state.copyWith(items: updatedItems));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final existingItemIndex = state.items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingItemIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingItemIndex];
      if (existingItem.quantity > 1) {
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedItems.removeAt(existingItemIndex);
      }
      emit(state.copyWith(items: updatedItems));
    }
  }
}
