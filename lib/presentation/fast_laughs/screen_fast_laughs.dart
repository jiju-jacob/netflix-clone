import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_app/presentation/fast_laughs/widgets/video_list_item.dart';

class ScreenFastLaughs extends StatelessWidget {
  const ScreenFastLaughs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastlaughBloc>(context).add(const Initialize());
    });

    return Scaffold(
      body: SafeArea(child: BlocBuilder<FastlaughBloc, FastlaughState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return const Center(child: Text("error while fetching video"));
          } else if (state.videosList.isEmpty) {
            return const Center(child: Text("video list empty"));
          } else {
            return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videosList.length,
                  (index) => VideoListItemInheritedWidget(
                    widget: VideoListItem(
                      key: Key(index.toString()),
                      index: index,
                    ),
                    movieData: state.videosList[index],
                  ),
                ));
          }
        },
      )),
    );
  }
}
