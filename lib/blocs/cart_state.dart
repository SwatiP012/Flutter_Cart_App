import 'package:equatable/equatable.dart';
import '../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalQuantity =>
      items.fold(0, (sum, item) => sum + item.quantity.toInt());

  @override
  List<Object?> get props => [items];
}
