// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_hall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaHall _$CinemaHallFromJson(Map<String, dynamic> json) {
  return CinemaHall(
    cinemaHallId: json['cinemaHallId'] as int,
    seats: json['seats'] as int,
    rows: json['rows'] as int,
  );
}

Map<String, dynamic> _$CinemaHallToJson(CinemaHall instance) =>
    <String, dynamic>{
      'cinemaHallId': instance.cinemaHallId,
      'seats': instance.seats,
      'rows': instance.rows,
    };
