import 'package:json_annotation/json_annotation.dart';

part 'cinema_hall.g.dart';

@JsonSerializable()
class CinemaHall {
  final int cinemaHallId;
  final int seats;
  final int rows;

  CinemaHall({
    required this.cinemaHallId,
    required this.seats,
    required this.rows,
  });

  factory CinemaHall.fromJson(Map<String, dynamic> json) => _$CinemaHallFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaHallToJson(this);
}
