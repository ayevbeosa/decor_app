import 'package:decor_app/models/product.dart';
import 'package:decor_app/providers/cart_provider.dart';
import 'package:decor_app/ui/widgets/cart_item_card.dart';
import 'package:decor_app/ui/widgets/empty_cart.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:decor_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AnimationMixin {
  final _enterTween = TimelineTween<EnterCartProps>()
    ..addScene(
      begin: Duration.zero,
      end: const Duration(milliseconds: 10000),
      curve: Curves.easeOut,
    ).animate(
      EnterCartProps.title,
      tween: Tween<double>(begin: -180.0, end: 0.0),
    )
    ..addScene(
      begin: Duration.zero,
      end: const Duration(milliseconds: 20000),
      curve: Curves.elasticInOut,
    ).animate(
      EnterCartProps.list,
      tween: Tween<double>(begin: 1.05, end: 0.0),
    )
    ..addScene(
      begin: Duration.zero,
      end: const Duration(milliseconds: 25000),
      curve: Curves.easeIn,
    ).animate(
      EnterCartProps.total,
      tween: Tween<double>(begin: 0.0, end: 1.0),
    );

  late Animation<TimelineValue<EnterCartProps>> _enterAnimation;

  List<Product> cartItems = [];

  @override
  void initState() {
    _enterAnimation = _enterTween.animate(controller);

    controller.play(duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final cartProvider = context.watch<CartProvider>();

    cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.translate(
              offset: Offset(
                _enterAnimation.value.get(EnterCartProps.title),
                0.0,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Cart',
                  style: TextStyle(
                    color: kTextPrimaryColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: Visibility(
                visible: cartItems.isNotEmpty,
                child: FractionalTranslation(
                  translation: Offset(
                    0.0,
                    _enterAnimation.value.get(EnterCartProps.list),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    children: List.generate(
                      cartItems.length,
                      (index) {
                        return CartItemCard(
                          product: cartItems[index],
                          increment: () {
                            cartProvider.increaseQuantity(cartItems[index]);
                          },
                          decrement: () {
                            if (cartItems[index].quantity > 1) {
                              cartProvider.decreaseQuantity(cartItems[index]);
                            } else {
                              cartProvider.removeCartItem(cartItems[index]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                replacement: const EmptyCart(),
              ),
            ),
            Visibility(
              visible: cartItems.isNotEmpty,
              child: Opacity(
                opacity: _enterAnimation.value.get(EnterCartProps.total),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        '\$' +
                            cartItems
                                .fold(
                                  0,
                                  (int prev, e) =>
                                      prev + (e.price * e.quantity),
                                )
                                .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 63.0)),
          ],
        ),
      ),
    );
  }
}
