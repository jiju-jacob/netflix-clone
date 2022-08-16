import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/presentation/widgets/app_bar_widget.dart';

import '../../core/colors/colors.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(
              title: "Downloads",
            )),
        body: ListView(
          children: [
            kHeigth,
            const _SmartDownloads(),
            kHeigth,
            const Text(
              "Introducing Downloads for you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kWhite,
              ),
            ),
            kHeigth,
            const Text(
              "Smart Downlfgk jghsdklfdh glkdhglkdfjgd\nlfkghj gfdg l;hglkhglk hsglkhgjkhfdlkg hgfgkgh f\nfgboads",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            BlocBuilder<DownloadsBloc, DownloadsState>(
              builder: (context, state) {
                return SizedBox(
                  width: size.width,
                  height: size.width,
                  child: !state.isLoading && state.downloads != null
                      ? Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CircleAvatar(
                              radius: size.width * 0.4,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                            ),
                            DownloadsImageWidget(
                              image:
                                  "$imageAppendURL${state.downloads?[0].posterPath}",
                              margin: EdgeInsets.only(right: 140, bottom: 50),
                              angle: -20,
                              size: Size(size.width * 0.4, size.width * 0.58),
                            ),
                            DownloadsImageWidget(
                              image:
                                  "$imageAppendURL${state.downloads?[1].posterPath}",
                              margin: EdgeInsets.only(left: 140, bottom: 50),
                              angle: 20,
                              size: Size(size.width * 0.4, size.width * 0.58),
                            ),
                            DownloadsImageWidget(
                              radius: 10,
                              image:
                                  "$imageAppendURL${state.downloads?[2].posterPath}",
                              margin: EdgeInsets.only(bottom: 10),
                              size: Size(size.width * 0.45, size.width * 0.65),
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                );
              },
            ),
            MaterialButton(
              color: kButtonColorBlue,
              onPressed: () {},
              child: const Text(
                "Set up",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MaterialButton(
              color: kButtonColorWhite,
              onPressed: () {},
              child: const Text(
                "See what you can download",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ));
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth,
        Icon(
          Icons.settings,
          color: kWhite,
        ),
        kWidth,
        Text("Smart Downloads"),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    Key? key,
    required this.image,
    required this.margin,
    required this.size,
    this.angle = 0,
    this.radius = 10,
  }) : super(key: key);

  final String image;
  final EdgeInsets margin;
  final Size size;
  final double angle;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            )),
      ),
    );
  }
}
