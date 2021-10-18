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
            return db.Reservations
                .Include("User")
                .Include("Seance")
                .ToList();
        }
    }
}