import 'package:cinema_reservations/model/api/login_request.dart';
import 'package:cinema_reservations/model/api/login_response.dart';
import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/repository/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'movie.dart';

class AppState extends ChangeNotifier {
  ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://localhost:5000');

  // ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://192.168.0.174:5000');

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  User? _user;

  User? get user => _user;

  Future<User?> logIn(String login, String password) async {
    LoginResponse response;
    try {
      response =
      await _apiClient.login(LoginRequest(login: login, password: password));
    } catch (e) {
      return null;
    }

    _isLoggedIn = true;
    _user = User(userId: response.userId, login: login, role: response.role);
    notifyListeners();
    return _user;
  }

  Future<User?> register(String login, String password) async {
    LoginResponse response;

    try {
      response = await _apiClient.registerUser(
          LoginRequest(login: login, password: password));
    } catch (e) {
      return null;
    }

    _isLoggedIn = true;
    _user = User(userId: response.userId, login: login, role: response.role);
    notifyListeners();
    return _user;
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

  void startFetching() {
    _isFetching = true;
  }

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

    _movies = await _apiClient.getMovies();
    _cinemaHalls = await _apiClient.getCinemaHalls();
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
    print('fetching');

    _reservations = await _apiClient.getReservations();
    _isFetching = false;
    notifyListeners();
    print('fetched');
  }

  Future<User?> changeUserRole(User user) async {
    final u = User(userId: user.userId,
        login: user.login,
        role: user.role == Role.employee ? Role.regular : Role.employee);
    final userres = await _apiClient.updateUser(u);
    print(userres);
    final index = _users.indexWhere((element) => element.userId == u.userId);
    _users[index] = u;
    notifyListeners();
  }

  void createCinemaHall(int seats, int rows) async {
    await _apiClient.createCinemaHall(
        CinemaHall(cinemaHallId: 0, seats: seats, rows: rows));
  }

  void createMovie(String title, int duration) async {
    await _apiClient.createMovie(
        Movie(movieId: 0, title: title, duration: duration));
  }

  Future<bool> confirmReservation(Reservation reservation) async {
    try {
      await _apiClient.confirmReservation(reservation.reservationId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Reservation?> createReservation(Seance seance, int seat, row,
      bool isTemporary) async {
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

  Future<Seance> createSeance(CinemaHall selectedHall,
      Movie selectedMovie,
      DateTime selectedDate,) async {
    return await _apiClient.createSeance(
      Seance(
          seanceId: 0,
          movie: selectedMovie,
          cinemaHall: selectedHall,
          startTime: selectedDate),
    );
  }
}
