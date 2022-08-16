import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/new_and_hot/hot_and_new_service.dart';

import '../../domain/new_and_hot/model/hot_and_new_response.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInCommingSoon>((event, emit) async {
      emit(const HotAndNewState(
        commingSoonList: [],
        everyonesWatchingList: [],
        isLoading: true,
        hasError: false,
      ));
      final result = await _hotAndNewService.getHotandNewMovieData();
      final newState = result.fold((l) {
        print(l);
        return state.copyWith(hasError: true, isLoading: false);
      }, (r) {
        return state.copyWith(
          hasError: false,
          isLoading: false,
          commingSoonList: r.results,
          everyonesWatchingList: state.everyonesWatchingList,
        );
      });
      emit(newState);
    });

    on<LoadDataInEveryonesWatching>((event, emit) async {
       emit( state.copyWith(
        commingSoonList: state.commingSoonList,
        everyonesWatchingList: state.everyonesWatchingList,
        isLoading: true,
        hasError: false,
      ));
      final result = await _hotAndNewService.getHotandNewTvData();
      final newState = result.fold((l) {
        print(l);
        return state.copyWith(hasError: true, isLoading: false);
      }, (r) {
        return state.copyWith(
          hasError: false,
          isLoading: false,
          commingSoonList: state.commingSoonList,
          everyonesWatchingList: r.results,
        );
      });
      emit(newState);
    });
  }
}
