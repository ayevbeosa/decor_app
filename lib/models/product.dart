class Product {
  final String name;
  final String desc;
  final String imgUrl;
  final String filters;
  int quantity;
  bool liked;
  int price;

  Product({
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.filters,
    this.quantity = 1,
    this.liked = false,
    this.price = 50,
  });
}
