import 'package:decor_app/models/product.dart';
import 'package:decor_app/providers/cart_provider.dart';
import 'package:decor_app/providers/product_provider.dart';
import 'package:decor_app/ui/widgets/cart_button.dart';
import 'package:decor_app/ui/widgets/color_mode.dart';
import 'package:decor_app/ui/widgets/leading_icon.dart';
import 'package:decor_app/ui/widgets/page_indicator.dart';
import 'package:decor_app/ui/widgets/product_like.dart';
import 'package:decor_app/ui/widgets/quantity_container.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with AnimationMixin {
  final List<Color> _productColors = [
    kFirstProductColor,
    kSecondProductColor,
    kThirdProductColor,
  ];

  int _currentIndex = 0;
  final _pageController = PageController(viewportFraction: 0.8);
  int quantity = 1;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: LeadingIcon(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  Navigator.of(context).pop();
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            Expanded(
              child: PlayAnimation<double>(
                tween: Tween<double>(begin: 1.05, end: 0.0),
                duration: const Duration(milliseconds: 3000),
                curve: Curves.elasticOut,
                builder: (context, child, value) {
                  return FractionalTranslation(
                    translation: Offset(value, 0.0),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      onPageChanged: (int? index) {
                        setState(() {
                          _currentIndex = index!;
                        });
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Image.asset(
                              widget.product.imgUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) {
                    return PageIndicator(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      isSelected: _currentIndex == index,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kTextPrimaryColor,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        Text(
                          widget.product.desc,
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kTextPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 34.0,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(color: kSubtitleTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: List.generate(
                        _productColors.length,
                        (index) {
                          return ColorMode(
                            color: _productColors[index],
                            active: _currentIndex == index,
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  QuantityContainer(
                    quantity: widget.product.quantity,
                    increment: () {
                      cartProvider.increaseQuantity(widget.product);
                    },
                    decrement: () {
                      cartProvider.decreaseQuantity(widget.product);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  ProductLike(
                    onPressed: () {
                      productProvider.changeLiked(widget.product);
                    },
                    isLiked: widget.product.liked,
                  ),
                  const Spacer(),
                  CartButton(
                    onTap: () {
                      cartProvider.addToCart(widget.product);
                      _showSnackBar();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.name} added to cart successfully!',
        ),
        backgroundColor: kDecorColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}
