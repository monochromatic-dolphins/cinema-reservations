// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    reservationId: json['reservationId'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    seance: Seance.fromJson(json['seance'] as Map<String, dynamic>),
    row: json['row'] as int,
    seat: json['seat'] as int,
    isTemporary: json['isTemporary'] as bool,
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'user': instance.user,
      'seance': instance.seance,
      'row': instance.row,
      'seat': instance.seat,
      'isTemporary': instance.isTemporary,
    };
