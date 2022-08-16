import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/new_and_hot/hot_and_new_service.dart';
import 'package:netflix_app/domain/new_and_hot/model/hot_and_new_response.dart';

import '../../domain/core/api_end_point.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewRepository implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewMovieData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.hotAndNewMovie,
      );
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseList = HotAndNewResponse.fromJson(response.data);

        return Right(responseList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewTvData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.hotAndNewTv,
      );
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseList = HotAndNewResponse.fromJson(response.data);

        return Right(responseList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
