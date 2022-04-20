import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';

class NoLikedProducts extends StatelessWidget {
  const NoLikedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.hourglass_empty_rounded,
            size: 80.0,
            color: kDecorColor,
          ),
          Text(
            'Your liked products will show here',
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
