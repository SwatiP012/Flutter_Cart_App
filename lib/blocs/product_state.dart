import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final List<Product> products;

  const ProductLoading({this.products = const []});

  @override
  List<Object?> get props => [products];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasMore;

  const ProductLoaded({
    required this.products,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [products, hasMore];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
