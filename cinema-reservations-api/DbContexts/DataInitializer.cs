using System;
using System.Collections.Generic;
using cinema_reservations_api.Model;

namespace cinema_reservations_api.DbContexts {
    public static class DataInitializer {
        
        public static void InitializeData(InMemoryDbContext context) {
            InitializeUsers(context);
            InitializeMovies(context);
            InitializeCinemaHalls(context);
            InitializeSeances(context);
            InitializeReservation(context);
        }

        private static void InitializeUsers(InMemoryDbContext context) {
            var users = new List<User> {
                new() {
                    UserId = 1,
                    Login = "admin",
                    Password = "benjo",
                    Role = "ADMIN"
                },
                new() {
                    UserId = 2,
                    Login = "andy",
                    Password = "234",
                    Role = "USER"
                }
            };
            context.Users.AddRange(users);
            context.SaveChanges();
        }

        private static void InitializeMovies(InMemoryDbContext context) {
            var movies = new List<Movie> {
                new() {
                    MovieId = 1,
                    Title = "ASP.NET Tutorial",
                    Duration = 390,
                },
                new() {
                    MovieId = 2,
                    Title = "Flutter Web Tutorial",
                    Duration = 120,
                }
            };
            context.Movies.AddRange(movies);
            context.SaveChanges();
        }

        private static void InitializeCinemaHalls(InMemoryDbContext context) {
            var cinemaHalls = new List<CinemaHall> {
                new() {
                    CinemaHallId = 1,
                    Rows = 3,
                    Seats = 7,
                },
                new() {
                    CinemaHallId = 2,
                    Rows = 5,
                    Seats = 5,
                }
            };
            context.CinemaHalls.AddRange(cinemaHalls);
            context.SaveChanges();
        }

        private static void InitializeSeances(InMemoryDbContext context) {
            var seances = new List<Seance> {
                new() {
                    SeanceId = 1,
                    Movie = context.Movies.Find(1),
                    CinemaHall = context.CinemaHalls.Find(1),
                    StartTime = new DateTime(2021, 11, 1, 12, 0, 0)
                },
                new() {
                    SeanceId = 2,
                    Movie = context.Movies.Find(2),
                    CinemaHall = context.CinemaHalls.Find(1),
                    StartTime = new DateTime(2021, 11, 1, 15, 30, 0)
                }
            };
            context.Seances.AddRange(seances);
            context.SaveChanges();
        }

        private static void InitializeReservation(InMemoryDbContext context) {
            var reservation = new Reservation {
                ReservationId = 1,
                IsTemporary = false,
                User = context.Users.Find(2),
                Seance = context.Seances.Find(1),
                Row = 2,
                Seat = 3,
            };
            context.Reservations.Add(reservation);
            context.SaveChanges();
        }
    }
}