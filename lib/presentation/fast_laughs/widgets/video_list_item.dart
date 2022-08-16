import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../core/colors/colors.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  VideoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          onStateChanged: (bool isPlaying) {},
          videoUrl: videoUrl,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //left side
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.volume_mute,
                        color: kWhite,
                        size: 30,
                      ),
                    ),
                  ),

                  //right side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendURL$posterPath'),
                      ),
                      ValueListenableBuilder(
                        valueListenable: likedVideosIdsNotifier,
                        builder: (context, Set<int> newLikedListIds, _) {
                          final _index = index;
                          if (newLikedListIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                likedVideosIdsNotifier.value.remove(_index);
                                likedVideosIdsNotifier.notifyListeners();
                              },
                              child: const VideoActions(
                                icon: Icons.favorite_outline,
                                title: "liked",
                              ),
                            );
                          }
                          // else {
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.add(_index);
                              likedVideosIdsNotifier.notifyListeners();
                            },
                            child: const VideoActions(
                              icon: Icons.emoji_emotions,
                              title: "lol",
                            ),
                          );
                          // }
                          // return VideoActions(
                          //   icon: Icons.emoji_emotions,
                          //   title: "lol",
                          // );
                        },
                      ),
                      VideoActions(
                        icon: Icons.add,
                        title: "My List",
                      ),
                      GestureDetector(
                        onTap: () {
                          final movieName =
                              VideoListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .title;
                          if (movieName != null) {
                            print('object');
                            Share.share(movieName);
                          }
                        },
                        child: VideoActions(
                          icon: Icons.share,
                          title: "Share",
                        ),
                      ),
                      VideoActions(
                        icon: Icons.play_arrow,
                        title: "Play",
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}

class VideoActions extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActions({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(title),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {Key? key, required this.videoUrl, required this.onStateChanged})
      : super(key: key);

  @override
  _FastLaughVideoPlayerState createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController))
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
