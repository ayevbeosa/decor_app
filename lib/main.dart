import 'package:decor_app/providers/cart_provider.dart';
import 'package:decor_app/providers/product_provider.dart';
import 'package:decor_app/ui/pages/landing_page.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => ProductProvider(),
        ),
        ListenableProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Decor App',
        theme: ThemeData(
          textTheme: GoogleFonts.comicNeueTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: kBgColor,
          primaryColor: kDecorColor,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
