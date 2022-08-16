import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../widgets/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  final List<String> imageUrls;
  const NumberTitleCard({
    Key? key,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: 'Top 10 Trending this year'),
        kHeigth,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              imageUrls.length,
              (index) => NumberCard(
                index: index,
                url: imageUrls[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
