import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;

  const PageIndicator({
    Key? key,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
          color: isSelected ? kIndicatorColor : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
