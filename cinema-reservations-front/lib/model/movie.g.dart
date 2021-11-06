// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    movieId: json['movieId'] as int,
    title: json['title'] as String,
    duration: json['duration'] as int,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'movieId': instance.movieId,
      'title': instance.title,
      'duration': instance.duration,
    };
