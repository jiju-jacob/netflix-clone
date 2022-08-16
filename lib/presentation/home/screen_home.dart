import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/presentation/home/widgets/background_card.dart';
import 'package:netflix_app/presentation/home/widgets/number_card.dart';

import '../../application/home/home_bloc.dart';
import '../../core/constants.dart';
import '../widgets/main_item_card.dart';
import '../widgets/main_title.dart';
import '../widgets/main_title_card.dart';
import 'widgets/custom_button_widget.dart';
import 'widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('object');
      BlocProvider.of<HomeBloc>(context)
          .add(const HomeEvent.getHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: ((context, value, child) {
        return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              print(direction);
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return false;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.isError) {
                      return Center(
                        child: Text(
                          'Error while loading home screen',
                          style: TextStyle(
                            color: kWhite,
                          ),
                        ),
                      );
                    }
                    final _releasedPastYear = state.pastYearMovieList.map((e) {
                      return '$imageAppendURL${e.posterPath}';
                    }).toList();
                    final _trending = state.trendingMovieList.map((e) {
                      return '$imageAppendURL${e.posterPath}';
                    }).toList();
                    // _trending.shuffle();
                    final _tenseDramas = state.tenseDramasMovieList.map((e) {
                      return '$imageAppendURL${e.posterPath}';
                    }).toList();
                    final _southIndian = state.southIndianMovieList.map((e) {
                      return '$imageAppendURL${e.posterPath}';
                    }).toList();
                    // _southIndian.shuffle();
                    return ListView(
                      children: [
                        BackGroundCard(url: '$imageAppendURL/4Q1n3TwieoULnuaztu9aFjqHDTI.jpg',),
                        kHeigth,
                        kHeigth,
                        MainTitleCard(
                          title: 'Released in the past year',
                          posterList: _releasedPastYear,
                        ),
                        kHeigth,
                        MainTitleCard(
                          title: 'Top Picks',
                          posterList: _trending,
                        ),
                        kHeigth,
                        NumberTitleCard(
                            imageUrls: state.trendingTvList
                                .map((e) => '$imageAppendURL${e.posterPath}')
                                .toList()),
                        kHeigth,
                        MainTitleCard(
                          title: 'Tense Dramas',
                          posterList: _tenseDramas,
                        ),
                        kHeigth,
                        MainTitleCard(
                          title: 'Soputh Indian Cinema',
                          posterList: _southIndian,
                        ),
                        kHeigth,
                      ],
                    );
                  },
                ),
                scrollNotifier.value
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 2000),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://cdn-images-1.medium.com/max/1200/1*ty4NvNrGg4ReETxqU2N3Og.png',
                                  width: 70,
                                  height: 70,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                kWidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                kWidth
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'TV Shows',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Movies',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : kHeigth
              ],
            ));
      }),
    ));
  }
}
