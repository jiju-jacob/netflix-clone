import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import 'custom_button_widget.dart';

class BackGroundCard extends StatelessWidget {
  final String url;
  const BackGroundCard({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
            borderRadius: kRadius20,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(
                  icon: Icons.add,
                  title: 'My List',
                ),
                _PlayButton(),
                CustomButtonWidget(
                  icon: Icons.info,
                  title: 'Info',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
      icon: Icon(
        Icons.play_arrow,
        size: 30,
        color: kBlack,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Play',
          style: TextStyle(fontSize: 20, color: kBlack),
        ),
      ),
    );
  }
}
