import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Ionicons.cart_outline,
            size: 80.0,
            color: kDecorColor,
          ),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24.0,
              color: kDecorColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
