import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/product_list/product_list_event.dart';
import '../../blocs/product_list/product_list_state.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductService _productService;

  ProductListBloc(this._productService) : super(ProductListInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductListState> emit,
  ) async {
    emit(ProductListLoading());
    try {
      final products = await _productService.getProducts();
      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
