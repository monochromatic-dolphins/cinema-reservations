// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seance _$SeanceFromJson(Map<String, dynamic> json) {
  return Seance(
    id: json['id'] as int,
    movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
    cinemaHall: CinemaHall.fromJson(json['cinemaHall'] as Map<String, dynamic>),
    startTime: DateTime.parse(json['startTime'] as String),
  );
}

Map<String, dynamic> _$SeanceToJson(Seance instance) => <String, dynamic>{
      'id': instance.id,
      'movie': instance.movie,
      'cinemaHall': instance.cinemaHall,
      'startTime': instance.startTime.toIso8601String(),
    };
