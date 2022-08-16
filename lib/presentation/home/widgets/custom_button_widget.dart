import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.iconSize = 30,
    this.textSize = 16,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhite,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(fontSize: textSize),
        )
      ],
    );
  }
}
