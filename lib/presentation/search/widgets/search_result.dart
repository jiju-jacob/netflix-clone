import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';

import '../../../core/constants.dart';

const imageUrlf =
    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/d26S5EfVXLNxRXqyFy1yyl3qRq3.jpg";

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Moviess and TV"),
        kHeigth,
        Expanded(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1 / 2,
              children: List.generate(
                state.searchListResult.length,
                (index) {
                  final movie = state.searchListResult[index];
                  return MainCard(
                    imageUrl: movie.posterPathUrl,
                  );
                },
              ),
            );
          },
        )),
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        child: Image.network(
          imageUrl,
          //  width: 40,
          //  height: 40,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Text('unable to load image');
          },
        )
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(imageUrl),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        );
  }
}
