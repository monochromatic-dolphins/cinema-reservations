using cinema_reservations_api.Model;
using Microsoft.EntityFrameworkCore;

namespace cinema_reservations_api.DbContexts {
    public class InMemoryDbContext: DbContext {

        public InMemoryDbContext(DbContextOptions<InMemoryDbContext> options) : base(options) {
        }
        public DbSet<User> Users { get; set; }
        public DbSet<Movie> Movies { get; set; }
        public DbSet<CinemaHall> CinemaHalls { get; set; }
        public DbSet<Seance> Seances { get; set; }
        public DbSet<Reservation> Reservations { get; set; }

    }
}