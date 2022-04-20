import 'package:decor_app/ui/pages/cart_page.dart';
import 'package:decor_app/ui/pages/home_page.dart';
import 'package:decor_app/ui/pages/liked_products_page.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({Key? key}) : super(key: key);

  static final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Feather.home),
      activeColorPrimary: kSelectedItemColor,
      inactiveColorPrimary: kUnSelectedItemColor,
      iconSize: 20.0,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Feather.heart),
      activeColorPrimary: kSelectedItemColor,
      inactiveColorPrimary: kUnSelectedItemColor,
      iconSize: 20.0,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Feather.shopping_cart),
      activeColorPrimary: kSelectedItemColor,
      inactiveColorPrimary: kUnSelectedItemColor,
      iconSize: 20.0,
    ),
  ];

  final List<Widget> _pages = [
    const HomePage(),
    const LikedProductsPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _pages,
      items: _items,
      confineInSafeArea: true,
      backgroundColor: kBottomNavBgColor,
      navBarStyle: NavBarStyle.style6,
      margin: const EdgeInsets.only(
        bottom: 32.0,
        left: 32.0,
        right: 32.0,
      ),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: kBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            spreadRadius: 0,
            blurRadius: 48,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
