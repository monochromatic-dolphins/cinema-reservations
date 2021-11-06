import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/mocks.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/repository/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'movie.dart';

class AppState extends ChangeNotifier {
  ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://localhost:5000');

  // ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://192.168.0.173');

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  User? _user;

  User? get user => _user;

  void logIn() {
    _isLoggedIn = true;
    _user = User(userId: 3, login: 'kul', role: Role.employee);
    notifyListeners();
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }

  List<Seance> _seances = [];

  List<Seance> get seances => _seances;

  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  List<User> _users = [];

  List<User> get users => _users;

  List<CinemaHall> _cinemaHalls = [];

  List<CinemaHall> get cinemaHalls => _cinemaHalls;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> fetchUserCrudPageData() async {
    _isFetching = true;
    notifyListeners();
    _users = await _apiClient.getUsers();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchSeanceCrudPageData() async {
    _isFetching = true;
    notifyListeners();

    _movies = await _apiClient.getMovies().catchError((_) => () {
          print('movie');
          return <Movie>[];
        }());
    _cinemaHalls = await _apiClient.getCinemaHalls().catchError((_) => () {
          print('cinema hall');
          return <CinemaHall>[];
        }());
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchHomePageData() async {
    _isFetching = true;
    notifyListeners();

    _movies = await _apiClient.getMovies();
    _seances = await _apiClient.getSeances();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchReservationPageData() async {
    _isFetching = true;
    notifyListeners();

    _reservations = await _apiClient.getReservations();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> changeUserRole(User user) async {
    // TODO
  }

  void createCinemaHall(String seats, String rows) {
    // TODO
  }

  void createMovie(String title, String duration) {
    // TODO
  }

  Future<Reservation?> confirmReservation(Reservation reservation) async {
    // MISSING: Change reservation to not temporary
    try {
      return await _apiClient.confirmReservation(reservation.reservationId);
    } catch (e) {
      return null;
    }
  }

  Future<Reservation?> createReservation(
      Seance seance, int seat, row, bool isTemporary) async {
    // MISSING: Return null on error
    final reservation = Reservation(
      reservationId: 0,
      user: _user!,
      seance: seance,
      row: row,
      seat: seat,
      isTemporary: isTemporary,
    );
    try {
      return await _apiClient.createReservation(reservation);
    } catch (e) {
      return null;
    }
  }

  Future<Seance> createSeance(
    CinemaHall selectedHall,
    Movie selectedMovie,
    DateTime selectedDate,
  ) async {
    return await _apiClient.createSeance(
      Seance(
          seanceId: 0,
          movie: selectedMovie,
          cinemaHall: selectedHall,
          startTime: selectedDate),
    );
  }
}
