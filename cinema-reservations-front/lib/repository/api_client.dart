import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.users)
  Future<List<User>> getUsers();

  @GET(Apis.movies)
  Future<List<Movie>> getMovies();

  @GET(Apis.cinemaHall)
  Future<List<CinemaHall>> getCinemaHalls();

  @GET(Apis.reservations)
  Future<List<Reservation>> getReservations();
}

class Apis {
  static const users = '/users';
  static const movies = '/movies';
  static const cinemaHall = '/cinema-hall';
  static const reservations = '/reservations';
}