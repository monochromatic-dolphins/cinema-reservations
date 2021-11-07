using System.Collections.Generic;
using System.Linq;
using cinema_reservations_api.DbContexts;
using cinema_reservations_api.Model;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api.Repository {
    public class MovieRepository {

        private readonly IServiceScopeFactory _scopeFactory;

        public MovieRepository(IServiceScopeFactory scopeFactory) {
            _scopeFactory = scopeFactory;
        }

        public IEnumerable<Movie> GetAllMovies() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.Movies.ToList();
        }

        public Movie CreateMovie(Movie movie) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var createdMovie = db.Movies
                .Add(movie)
                .Entity;
            db.SaveChanges();
            return createdMovie;
        }
    }
}