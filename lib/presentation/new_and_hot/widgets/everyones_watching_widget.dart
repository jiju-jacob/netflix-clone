import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../domain/new_and_hot/model/hot_and_new_response.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final HotAndNewData data;
  const EveryonesWatchingWidget({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeigth,
        Text(
          data.name ?? 'no name provided',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        kHeigth,
        Text(
          data.overview ?? 'no description',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 50,
        ),
        VideoWidget(
          url:
             '$imageAppendURL${data.posterPath}'),
        kHeigth,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              title: 'Share',
              icon: Icons.share,
              iconSize: 25,
              textSize: 15,
            ),
            kWidth,
            CustomButtonWidget(
              title: 'My List',
              icon: Icons.add,
              iconSize: 25,
              textSize: 15,
            ),
            kWidth,
            CustomButtonWidget(
              title: 'Play',
              icon: Icons.play_arrow,
              iconSize: 25,
              textSize: 15,
            ),
          ],
        ),
        kHeigth,
        kHeigth,
      ],
    );
  }
}
