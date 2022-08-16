// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_and_new_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotAndNewResponse _$HotAndNewResponseFromJson(Map<String, dynamic> json) =>
    HotAndNewResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => HotAndNewData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HotAndNewResponseToJson(HotAndNewResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };

HotAndNewData _$HotAndNewDataFromJson(Map<String, dynamic> json) =>
    HotAndNewData(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
    )
      ..originalname = json['original_name'] as String?
      ..name = json['name'] as String?;

Map<String, dynamic> _$HotAndNewDataToJson(HotAndNewData instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'original_name': instance.originalname,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
    };
