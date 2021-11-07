using System;
using System.Collections.Generic;
using System.Linq;
using cinema_reservations_api.DbContexts;
using cinema_reservations_api.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api.Repository {
    public class ReservationRepository {

        private readonly IServiceScopeFactory _scopeFactory;

        public ReservationRepository(IServiceScopeFactory scopeFactory) {
            _scopeFactory = scopeFactory;
        }
        public IEnumerable<Reservation> GetAllReservations() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            DeleteAllOutdatedReservation();
            return db.Reservations
                .Include("User")
                .Include("Seance")
                .ToList();
        }

        private void DeleteAllOutdatedReservation() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var outdatedReservations = db.Reservations.Where(reservation => reservation.IsTemporary && (reservation.CreatedTime - DateTime.Now).TotalMinutes > 5).ToList();
            db.RemoveRange(outdatedReservations);
            db.SaveChanges();
        }

        public Reservation CreateReservation(Reservation reservation) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var user = db.Users.Find(reservation.User.UserId);
            var seance = db.Seances.Find(reservation.Seance.SeanceId);
            var createdTime = DateTime.Now;
            reservation.CreatedTime = createdTime;
            reservation.User = user;
            reservation.Seance = seance;
            var createdReservation = db.Reservations
                .Add(reservation)
                .Entity;
            db.SaveChanges();
            return createdReservation;
        }

        public Reservation ConfirmReservation(int id) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var reservation = db.Reservations.Find(id);
            reservation.IsTemporary = false;
            var confirmedReservation = db.Reservations.Update(reservation).Entity;
            db.SaveChanges();
            return confirmedReservation;
        }
    }
}