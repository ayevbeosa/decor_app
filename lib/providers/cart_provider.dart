import 'package:decor_app/models/product.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<Product> get cartItems => _cart;

  final List<Product> _cart = [];

  void addToCart(Product product) {
    if (_cart.isNotEmpty) {
      final index = _cart.indexOf(product);
      if (index != -1) {
        _cart[index].quantity += product.quantity;
      } else {
        _cart.add(product);
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final index = _cart.indexOf(product);
    if (index != -1) {
      _cart[index].quantity++;
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    final index = _cart.indexOf(product);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
        notifyListeners();
      }
    }
  }

  void removeCartItem(Product product) {
    final index = _cart.indexOf(product);
    if (index != -1) {
      _cart.removeAt(index);
      notifyListeners();
    }
  }
}
