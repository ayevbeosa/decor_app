import 'package:decor_app/models/product.dart';
import 'package:decor_app/ui/widgets/quantity_container.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback increment;
  final VoidCallback decrement;

  const CartItemCard({
    Key? key,
    required this.product,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 95.0,
          color: Colors.white10,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  product.imgUrl,
                  fit: BoxFit.fill,
                  width: 90.0,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: kTextPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        product.desc,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: kTextPrimaryColor,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 2.0)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: QuantityContainer(
                          quantity: product.quantity,
                          increment: increment,
                          decrement: decrement,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
