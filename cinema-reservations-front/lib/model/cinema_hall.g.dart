// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_hall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaHall _$CinemaHallFromJson(Map<String, dynamic> json) {
  return CinemaHall(
    id: json['id'] as int,
    seats: json['seats'] as int,
    rows: json['rows'] as int,
  );
}

Map<String, dynamic> _$CinemaHallToJson(CinemaHall instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seats': instance.seats,
      'rows': instance.rows,
    };
