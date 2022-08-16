import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/new_and_hot/model/hot_and_new_response.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewMovieData();
  Future<Either<MainFailure, HotAndNewResponse>> getHotandNewTvData();
  
}