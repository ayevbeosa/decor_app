import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductLike extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLiked;

  const ProductLike({
    Key? key,
    required this.onPressed,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Ink(
        width: 50,
        height: 50,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: kLeadingIconColor,
        ),
        child: Icon(
          isLiked ? Ionicons.heart : Ionicons.heart_outline,
          color: isLiked ? Colors.red : kHintTextColor,
        ),
      ),
    );
  }
}
