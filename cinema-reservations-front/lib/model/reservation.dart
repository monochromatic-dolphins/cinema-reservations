import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  final int reservationId;
  final User user;
  final Seance seance;
  final int row;
  final int seat;
  final bool isTemporary;

  Reservation({
    required this.reservationId,
    required this.user,
    required this.seance,
    required this.row,
    required this.seat,
    required this.isTemporary,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$ReservationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}