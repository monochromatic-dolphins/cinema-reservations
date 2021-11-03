import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/mocks.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/repository/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'movie.dart';

class AppState extends ChangeNotifier {
  ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://192.168.43.115:5000');
  // ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://192.168.0.173');

  bool _isLoggedIn = false;
  bool get isLoggedIn =>_isLoggedIn;

  User? _user;
  User? get user => _user;

  void logIn() {
    _isLoggedIn = true;
    _user = User(id: 3, login: 'kul', role: Role.employee);
    notifyListeners();
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }

  List<Seance> _seances = [];
  List<Seance> get seances {
    _seances = Mocks.seances;
    return _seances;
  }

  List<Movie> _movies = [];
  List<Movie> get movies {
    _movies = Mocks.movies;
    return _movies;
  }

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

    _movies = await _apiClient.getMovies();
    _cinemaHalls = await _apiClient.getCinemaHalls();
    _isFetching = false;
    notifyListeners();
  }

  void createCinemaHall(String seats, String rows) {
  // TODO
  }

  void createMovie(String title, String duration) {
    // TODO
  }

  void createSeance(CinemaHall selectedHall, Movie selectedMovie, DateTime selectedDate) {
    // TODO
  }
}
