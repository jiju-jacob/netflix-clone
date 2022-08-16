import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.red,
                ));
              }
            },
            errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
              return Center(
                  child: Icon(
                Icons.wifi,
                color: kWhite,
              ));
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_mute,
                color: kWhite,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
