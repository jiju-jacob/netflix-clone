import 'package:flutter/material.dart';

import '../../core/constants.dart';

class MainItemCard extends StatelessWidget {
  final String url;
  const MainItemCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 130,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: kRadius20,
            image: DecorationImage(
              image: NetworkImage(
                url,
              ),
            )));
  }
}
