import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/new_and_hot/hot_and_new_service.dart';

import '../../domain/new_and_hot/model/hot_and_new_response.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      emit(state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          isLoading: true,
          isError: false));
      final _movieResult = await _homeService.getHotandNewMovieData();
      final _tvResult = await _homeService.getHotandNewTvData();
      final _state1 = _movieResult.fold((l) {
        return state.copyWith(isError: true, isLoading: false);
      }, (r) {
        final pastYear = r.results.sublist(5, 15);;
        final trending = r.results.sublist(0, 10);
        final dramas = r.results.sublist(2, 8);;
        final southIndian = r.results.sublist(10, 20);
        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();
        return state.copyWith(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          isError: false,
          isLoading: false,
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tenseDramasMovieList: dramas,
          southIndianMovieList: southIndian,
        );
      });
      emit(_state1);
      final _state2 = _tvResult.fold((l) {
        return state.copyWith(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            isError: true,
            isLoading: false);
      }, (r) {
        return HomeState(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          isError: false,
          isLoading: false,
          trendingTvList: r.results,
          pastYearMovieList: state.pastYearMovieList,
          southIndianMovieList: state.southIndianMovieList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          trendingMovieList: state.trendingMovieList,
        );
      });
      emit(_state2);
    });
  }
}
