import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

import '../../../core/constants.dart';
import '../../widgets/main_item_card.dart';
import '../../widgets/main_title.dart';

class NumberCard extends StatelessWidget {
  final String url;
  final int index;
  const NumberCard({Key? key, required this.index, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadius20,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(url)),
              ),
            ),
          ],
        ),
        Positioned(
            left: 13,
            bottom: -18,
            child: BorderedText(
              strokeWidth: 10.0,
              strokeColor: kWhite,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 100,
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black,
                ),
              ),
            )),
      ],
    );
  }
}
