using System.Collections.Generic;
using System.Linq;
using cinema_reservations_api.DbContexts;
using cinema_reservations_api.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api.Repository {
    public class SeanceRepository {

        private readonly IServiceScopeFactory _scopeFactory;

        public SeanceRepository(IServiceScopeFactory scopeFactory) {
            _scopeFactory = scopeFactory;
        }

        public IEnumerable<Seance> GetAllSeances() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.Seances
                .Include(obj => obj.Movie)
                .Include(obj => obj.CinemaHall)
                .ToList();
        }

        public Seance CreateSeance(Seance seance) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var movie = db.Movies.Find(seance.Movie.MovieId);
            var cinemaHall = db.CinemaHalls.Find(seance.CinemaHall.CinemaHallId);
            seance.Movie = movie;
            seance.CinemaHall = cinemaHall;
            var createdSeance = db.Seances
                .Add(seance)
                .Entity;
            db.SaveChanges();
            return createdSeance;
        }
    }
}