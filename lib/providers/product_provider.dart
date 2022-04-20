import 'package:decor_app/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> get products => _products;

  List<Product> get likedProducts =>
      _products.where((element) => element.liked).toList();

  void changeLiked(Product product) {
    final index = _products.indexOf(product);
    if (index != -1) {
      _products[index].liked = !_products[index].liked;
    }
    notifyListeners();
  }

  final List<Product> _products = [
    Product(
      name: 'Vase',
      desc: 'A beautiful vase',
      imgUrl: 'assets/images/vase.jpg',
      filters: 'trending, decor',
    ),
    Product(
      name: 'White Vase',
      desc: 'A white vase',
      imgUrl: 'assets/images/white_vase.jpg',
      filters: 'decor',
    ),
    Product(
      name: 'Lamp Holder',
      desc: 'Transparent Lamp Holder',
      imgUrl: 'assets/images/lamp_holder.jpg',
      filters: 'trending, decor',
    ),
    Product(
      name: 'Arm Chair',
      desc: 'Good for offices',
      imgUrl: 'assets/images/arm_chair.jpg',
      filters: 'trending, chairs',
    ),
    Product(
      name: 'Room Chair',
      desc: 'Good for homes',
      imgUrl: 'assets/images/room_chair.jpg',
      filters: 'chairs',
    ),
    Product(
      name: 'Wooden Chair',
      desc: 'Outdoors',
      imgUrl: 'assets/images/wooden_chair.jpg',
      filters: 'chairs',
    ),
  ];
}
