import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_event.dart';
import '../blocs/product_state.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;
  final List<Product> _products = [];
  bool _hasMore = true;

  ProductBloc(this._productService) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductLoading) return;

      if (_products.isEmpty) {
        emit(const ProductLoading(products: []));
      }

      final newProducts = await _productService.fetchProducts();
      _products.addAll(newProducts);
      _hasMore = _productService.hasMore;

      emit(ProductLoaded(products: _products, hasMore: _hasMore));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
