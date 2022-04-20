import 'package:decor_app/models/product.dart';
import 'package:decor_app/providers/product_provider.dart';
import 'package:decor_app/ui/pages/product_details_page.dart';
import 'package:decor_app/ui/widgets/liked_product_card.dart';
import 'package:decor_app/ui/widgets/no_liked_products.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:decor_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class LikedProductsPage extends StatefulWidget {
  const LikedProductsPage({Key? key}) : super(key: key);

  @override
  _LikedProductsPageState createState() => _LikedProductsPageState();
}

class _LikedProductsPageState extends State<LikedProductsPage>
    with AnimationMixin {
  final _enterTween = TimelineTween<EnterLikedProps>()
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 10),
      curve: Curves.easeOut,
    ).animate(
      EnterLikedProps.title,
      tween: Tween<double>(begin: -180.0, end: 0.0),
    )
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 20),
      curve: Curves.elasticInOut,
    ).animate(
      EnterLikedProps.list,
      tween: Tween<double>(begin: 1.0, end: 0.0),
    );

  late Animation<TimelineValue<EnterLikedProps>> _enterAnimation;

  List<Product> _products = [];

  @override
  void initState() {
    _enterAnimation = _enterTween.animate(controller);

    controller.play(duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _products = context.watch<ProductProvider>().likedProducts;

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.translate(
              offset: Offset(
                _enterAnimation.value.get(EnterLikedProps.title),
                0.0,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Liked Products',
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
                visible: _products.isNotEmpty,
                child: FractionalTranslation(
                  translation: Offset(
                    0.0,
                    _enterAnimation.value.get(EnterLikedProps.list),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    children: List.generate(
                      _products.length,
                      (index) {
                        return LikedProductCard(
                          product: _products[index],
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: ProductDetailsPage(
                                product: _products[index],
                              ),
                              withNavBar: false,
                            );
                          },
                          onLikePressed: () {
                            context
                                .read<ProductProvider>()
                                .changeLiked(_products[index]);
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ),
                replacement: const NoLikedProducts(),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 63.0)),
          ],
        ),
      ),
    );
  }
}
