part of 'fastlaugh_bloc.dart';

@freezed
class FastlaughEvent with _$FastlaughEvent {
  const factory FastlaughEvent.initalize() = Initialize;
  const factory FastlaughEvent.likeVideo({
    required int id,
  }) = LikeVideo;
  const factory FastlaughEvent.unlikeVideo({
    required int id,
  }) = UnlikeVideo;
}
