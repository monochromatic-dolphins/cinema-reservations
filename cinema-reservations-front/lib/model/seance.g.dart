// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seance _$SeanceFromJson(Map<String, dynamic> json) {
  return Seance(
    seanceId: json['seanceId'] as int,
    movie: json['movie'] == null
        ? null
        : Movie.fromJson(json['movie'] as Map<String, dynamic>),
    cinemaHall: json['cinemaHall'] == null
        ? null
        : CinemaHall.fromJson(json['cinemaHall'] as Map<String, dynamic>),
    startTime: DateTime.parse(json['startTime'] as String),
  );
}

Map<String, dynamic> _$SeanceToJson(Seance instance) => <String, dynamic>{
      'seanceId': instance.seanceId,
      'movie': instance.movie,
      'cinemaHall': instance.cinemaHall,
      'startTime': instance.startTime.toIso8601String(),
    };
