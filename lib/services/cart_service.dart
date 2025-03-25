import '../models/product_model.dart';
import '../models/cart_item.dart';

class CartService {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
  }

  void incrementQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    }
  }

  void decrementQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      final quantity = _items[index].quantity;
      if (quantity > 1) {
        _items[index] = _items[index].copyWith(quantity: quantity - 1);
      } else {
        removeItem(product);
      }
    }
  }

  void clearCart() {
    _items.clear();
  }
}
