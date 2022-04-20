import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: 'Search products',
        fillColor: Colors.white,
        filled: true,
        hintStyle: const TextStyle(
          color: kHintTextColor,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        prefixIcon: const Icon(
          Feather.search,
          color: kHintTextColor,
        ),
      ),
    );
  }
}
