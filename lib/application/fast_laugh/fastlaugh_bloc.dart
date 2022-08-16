import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fastlaugh_event.dart';
part 'fastlaugh_state.dart';
part 'fastlaugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
];

ValueNotifier<Set<int>> likedVideosIdsNotifier = ValueNotifier({});

@injectable
class FastlaughBloc extends Bloc<FastlaughEvent, FastlaughState> {
  FastlaughBloc(
    IDownloadsRepo _downloadService,
  ) : super(FastlaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(const FastlaughState(
        videosList: [],
        isLoading: true,
        isError: false,
      ));
      final result = await _downloadService.getDownloadsImage();
      final _state = result.fold(
          (l) => FastlaughState(
                videosList: [],
                isLoading: false,
                isError: true,
              ),
          (r) => FastlaughState(
                videosList: r,
                isLoading: false,
                isError: false,
              ));
      emit(_state);
    });

    on<LikeVideo>((event, emit) async {});

    on<UnlikeVideo>((event, emit) async {
      likedVideosIdsNotifier.value.remove(event.id);
    });
  }
}
