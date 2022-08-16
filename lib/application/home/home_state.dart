part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tenseDramasMovieList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory HomeState.initial() {
    return const HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tenseDramasMovieList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      isError: false,
    );
  }
}
