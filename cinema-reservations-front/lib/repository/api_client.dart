import 'package:cinema_reservations/model/api/login_request.dart';
import 'package:cinema_reservations/model/api/login_response.dart';
import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Users

  @POST(Apis.register)
  Future<LoginResponse> registerUser(@Body() LoginRequest request);

  @POST(Apis.login)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET(Apis.users)
  Future<List<User>> getUsers();

  @GET(Apis.users)
  Future<void> updateUser(@Body() User user);

  // Movies

  @GET(Apis.movies)
  Future<List<Movie>> getMovies();

  @POST(Apis.movies)
  Future<Movie> createMovie(@Body() Movie reservation);

  // Cinema Halls

  @GET(Apis.cinemaHall)
  Future<List<CinemaHall>> getCinemaHalls();

  @POST(Apis.cinemaHall)
  Future<CinemaHall> createCinemaHall(@Body() CinemaHall cinemaHall);

  // Reservations

  @GET(Apis.reservations)
  Future<List<Reservation>> getReservations();

  @POST(Apis.reservations)
  Future<Reservation> createReservation(@Body() Reservation reservation);

  @POST('${Apis.reservations}/confirm/{reservationId}')
  Future<Reservation> confirmReservation(@Path('reservationId') int reservationId);

  // Seances

  @GET(Apis.seances)
  Future<List<Seance>> getSeances();

  @POST(Apis.seances)
  Future<Seance> createSeance(@Body() Seance seance);
}

class Apis {
  static const users = '/users';
  static const register = '/register';
  static const login = '/login';
  static const movies = '/movies';
  static const cinemaHall = '/cinema-halls';
  static const reservations = '/reservations';
  static const seances = '/seances';
}