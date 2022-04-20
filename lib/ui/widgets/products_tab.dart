import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  final String tab;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const ProductsTab({
    Key? key,
    required this.tab,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: InkWell(
        onTap: onTap,
        splashColor: kSelectedTabColor.withOpacity(0.2),
        child: Column(
          children: [
            Text(
              tab,
              style: TextStyle(
                fontSize: 18.0,
                color: textColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 30.0,
              height: 2.0,
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
