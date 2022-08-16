import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/search/models/search_service.dart';
import 'package:netflix_app/infrastructure/search/search_repository.dart';

import '../../domain/downloads/i_downloads_repo.dart';
import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/models/search_response/search_response.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsService;
  final SearchService _searchService;
  SearchBloc(this._downloadsService, this._searchService)
      : super(SearchState.initial()) {
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchListResult: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }
      emit(const SearchState(
        searchListResult: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      // get trending
      final _result = await _downloadsService.getDownloadsImage();
      final _state = _result.fold((MainFailure f) {
        return const SearchState(
          searchListResult: [],
          idleList: [],
          isLoading: false,
          isError: true,
        );
      }, (List<Downloads> list) {
        return SearchState(
          searchListResult: [],
          idleList: list,
          isLoading: false,
          isError: false,
        );
      });
      emit(_state);
    });

    on<SearchMovie>((event, emit) async {
      // call search movie api
      emit(const SearchState(
        searchListResult: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold((MainFailure f) {
        return const SearchState(
          searchListResult: [],
          idleList: [],
          isLoading: false,
          isError: true,
        );
      }, (SearchResponse response) {
        return SearchState(
          searchListResult: response.results,
          idleList: [],
          isLoading: false,
          isError: false,
        );
      });
      emit(_state);
    });
  }
}
