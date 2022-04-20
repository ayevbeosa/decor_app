import 'package:decor_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LeadingIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const LeadingIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onPressed,
        icon: Ink(
          width: 50,
          height: 50,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: kLeadingIconColor,
          ),
          child: const Icon(
            Ionicons.ios_chevron_back,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
