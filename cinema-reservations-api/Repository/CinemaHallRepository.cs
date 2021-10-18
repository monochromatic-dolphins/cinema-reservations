using System.Collections.Generic;
using System.Linq;
using cinema_reservations_api.DbContexts;
using cinema_reservations_api.Model;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api.Repository {
    public class CinemaHallRepository {

        private readonly IServiceScopeFactory _scopeFactory;

        public CinemaHallRepository(IServiceScopeFactory scopeFactory) {
            _scopeFactory = scopeFactory;
        }
        public IEnumerable<CinemaHall> GetAllCinemaHalls() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.CinemaHalls.ToList();
        }
    }
}