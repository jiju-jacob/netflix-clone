import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/constants.dart';
import 'package:netflix_app/domain/core/debounce/debounce.dart';
import 'package:netflix_app/presentation/search/widgets/search_idle.dart';

import 'widgets/search_result.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    }));

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              prefixIcon: const Icon(CupertinoIcons.search),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                if (value.isEmpty) {
                  EasyDebounce.cancel('my-debouncer');
                  BlocProvider.of<SearchBloc>(context).add(const Initialize());
                  return;
                }
                EasyDebounce.debounce(
                    'my-debouncer', // <-- An ID for this particular debouncer
                    const Duration(
                        milliseconds: 1000), // <-- The debounce duration
                    () {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchMovie(movieQuery: value));
                } // <-- The target method∏
                    );
              },
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.searchListResult.isEmpty) {
                  return const Expanded(child: SearchIdleWidget());
                } else {
                  return const Expanded(child: SearchResult());
                }
              },
            ),
            // Expanded(child: SearchResult()),
          ],
        ),
      )),
    );
  }
}
