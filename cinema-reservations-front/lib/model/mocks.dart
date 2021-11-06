import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';

class Mocks {
  static final seances = [
    Seance(
      seanceId: 1,
      movie: _movie1,
      cinemaHall: _cinemaHall1,
      startTime: DateTime(2021, 10, 20, 19, 20),
    ),
    Seance(
      seanceId: 2,
      movie: _movie1,
      cinemaHall: _cinemaHall2,
      startTime: DateTime(2021, 10, 20, 21, 30),
    ),
    Seance(
      seanceId: 3,
      movie: _movie2,
      cinemaHall: _cinemaHall2,
      startTime: DateTime(2021, 10, 20, 19, 20),
    ),
    Seance(
      seanceId: 3,
      movie: _movie2,
      cinemaHall: _cinemaHall2,
      startTime: DateTime(2021, 10, 21, 19, 20),
    ),
  ];

  static final List<Movie> movies = [_movie1, _movie2];

  static final _movie1 = Movie(
    movieId: 1,
    title: "Harry Potter",
    duration: 120,
  );

  static final _movie2 = Movie(
    movieId: 2,
    title: "J Son 2",
    duration: 100,
  );

  static final _cinemaHall1 = CinemaHall(cinemaHallId: 1, seats: 5, rows: 6);
  static final _cinemaHall2 = CinemaHall(cinemaHallId: 2, seats: 6, rows: 7);

  static final user1 = User(userId: 1, role: Role.employee, login: 'colunira');
  static final user2 = User(userId: 2, role: Role.regular, login: 'szkaker');

  static final reservations = [
    Reservation(reservationId: 1, user: user1, seance: seances[1], row: 1, seat: 1, isTemporary: false),
    Reservation(reservationId: 2, user: user1, seance: seances[1], row: 1, seat: 2, isTemporary: false),
    Reservation(reservationId: 3, user: user2, seance: seances[1], row: 4, seat: 4, isTemporary: false),
    Reservation(reservationId: 4, user: user2, seance: seances[1], row: 4, seat: 5, isTemporary: false),
  ];
}
