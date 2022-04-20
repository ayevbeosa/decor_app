import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class QuantityContainer extends StatelessWidget {
  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;

  const QuantityContainer({
    Key? key,
    required this.quantity,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCounterBgColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: decrement,
            iconSize: 25.0,
            color: Colors.black,
            padding: const EdgeInsets.all(6.0),
            splashRadius: 25.0,
            icon: const Icon(
              Feather.minus,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 2.0)),
          Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 6.0)),
          Container(
            height: 35.0,
            width: 35.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: IconButton(
              onPressed: increment,
              iconSize: 20.0,
              padding: const EdgeInsets.all(6.0),
              splashRadius: 25.0,
              color: Colors.white,
              icon: const Icon(
                Feather.plus,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
