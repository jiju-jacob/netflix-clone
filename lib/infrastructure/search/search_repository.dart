import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/api_end_point.dart';
import 'package:netflix_app/domain/search/models/search_response/search_response.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/search/models/search_service.dart';

@LazySingleton(as: SearchService)
class SearchRepository implements SearchService {
  @override
  Future<Either<MainFailure, SearchResponse>> searchMovies(
      {required String movieQuery}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {'query': movieQuery},
      );
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final searchList = SearchResponse.fromJson(response.data);

        return Right(searchList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
