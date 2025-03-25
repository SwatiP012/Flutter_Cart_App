import 'product_model.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  //  Used in CartService
  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  //  Used in totalAmount calculation
  double get totalPrice => product.price * quantity;
}
