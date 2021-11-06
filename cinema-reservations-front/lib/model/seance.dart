import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seance.g.dart';

@JsonSerializable()
class Seance {
  final int seanceId;
  final Movie? movie;
  final CinemaHall? cinemaHall;
  final DateTime startTime;

  Seance({
    required this.seanceId,
    required this.movie,
    required this.cinemaHall,
    required this.startTime,
  });

  factory Seance.fromJson(Map<String, dynamic> json) => _$SeanceFromJson(json);

  Map<String, dynamic> toJson() => _$SeanceToJson(this);
}
