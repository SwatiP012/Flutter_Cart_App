import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementQty extends CartEvent {
  final Product product;

  IncrementQty(this.product);

  @override
  List<Object?> get props => [product];
}

class DecrementQty extends CartEvent {
  final Product product;

  DecrementQty(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearCart extends CartEvent {}
