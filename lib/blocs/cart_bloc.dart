import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../services/cart_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService;

  CartBloc(this._cartService) : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncrementQty>(_onIncrementQty);
    on<DecrementQty>(_onDecrementQty);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    _cartService.addItem(event.product);
    emit(CartState(items: List.from(_cartService.items)));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    _cartService.removeItem(event.product);
    emit(CartState(items: List.from(_cartService.items)));
  }

  void _onIncrementQty(IncrementQty event, Emitter<CartState> emit) {
    _cartService.incrementQuantity(event.product);
    emit(CartState(items: List.from(_cartService.items)));
  }

  void _onDecrementQty(DecrementQty event, Emitter<CartState> emit) {
    _cartService.decrementQuantity(event.product);
    emit(CartState(items: List.from(_cartService.items)));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _cartService.clearCart();
    emit(CartState(items: List.from(_cartService.items)));
  }
}
