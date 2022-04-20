import 'package:decor_app/models/product.dart';
import 'package:decor_app/providers/product_provider.dart';
import 'package:decor_app/ui/pages/product_details_page.dart';
import 'package:decor_app/ui/widgets/filter_button.dart';
import 'package:decor_app/ui/widgets/product_card.dart';
import 'package:decor_app/ui/widgets/products_tab.dart';
import 'package:decor_app/ui/widgets/search_text_field.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:decor_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AnimationMixin {
  final _enterTween = TimelineTween<EnterHomeProps>()
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 10),
      curve: Curves.easeOut,
    )
        .animate(
          EnterHomeProps.title,
          tween: Tween<double>(begin: -180.0, end: 0.0),
        )
        .animate(
          EnterHomeProps.searchField,
          tween: Tween<double>(begin: -40, end: 0.0),
        )
        .animate(
          EnterHomeProps.filter,
          tween: Tween<double>(begin: 40.0, end: 0.0),
        )
        .animate(
          EnterHomeProps.tabs,
          tween: Tween<double>(begin: -1.0, end: 0.0),
        )
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 20),
      curve: Curves.elasticOut,
    ).animate(
      EnterHomeProps.list,
      tween: Tween<double>(begin: 1.0, end: 0.0),
    );

  late Animation<TimelineValue<EnterHomeProps>> _enterAnimation;

  static const _productsTab = [
    'Trending',
    'Decor',
    'Chairs',
  ];

  int _selectedTab = 0;

  List<Product> _products = [];

  final _scrollController = ScrollController();

  @override
  void initState() {
    _enterAnimation = _enterTween.animate(controller);

    controller.play(duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final productProvider = context.watch<ProductProvider>();

    _products = _getProductList(_selectedTab, productProvider.products);

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.translate(
              offset: Offset(
                _enterAnimation.value.get(EnterHomeProps.title),
                0.0,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Discover \nNew items',
                  style: TextStyle(
                    color: kTextPrimaryColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(
                        _enterAnimation.value.get(EnterHomeProps.searchField),
                        0.0,
                      ),
                      child: const SearchTextField(),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Transform.translate(
                    offset: Offset(
                      _enterAnimation.value.get(EnterHomeProps.filter),
                      0.0,
                    ),
                    child: const FilterButton(),
                  ),
                ],
              ),
            ),
            FractionalTranslation(
              translation: Offset(
                _enterAnimation.value.get(EnterHomeProps.tabs),
                0.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    _productsTab.length,
                    (index) {
                      return ProductsTab(
                        tab: _productsTab[index],
                        color: _selectedTab == index
                            ? kSelectedTabColor
                            : Colors.transparent,
                        textColor: _selectedTab == index
                            ? kSelectedTabColor
                            : kUnSelectedTabColor,
                        onTap: () {
                          setState(() {
                            _selectedTab = index;
                          });
                          _scrollController.jumpTo(0.0);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: FractionalTranslation(
                translation: Offset(
                  _enterAnimation.value.get(EnterHomeProps.list),
                  0.0,
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  children: List.generate(
                    _products.length,
                    (index) {
                      return ProductCard(
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
                          productProvider.changeLiked(_products[index]);
                          setState(() {});
                        },
                      );
                    },
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

  List<Product> _getProductList(
    int selectedIndex,
    List<Product> products,
  ) {
    if (selectedIndex == 0) {
      return products
          .where((element) => element.filters.contains('trending'))
          .toList();
    } else if (selectedIndex == 1) {
      return products
          .where((element) => element.filters.contains('decor'))
          .toList();
    } else if (selectedIndex == 2) {
      return products
          .where((element) => element.filters.contains('chairs'))
          .toList();
    } else {
      return List.empty();
    }
  }
}
