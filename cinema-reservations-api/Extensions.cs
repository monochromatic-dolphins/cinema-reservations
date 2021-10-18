using cinema_reservations_api.Repository;
using cinema_reservations_api.Services;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api {
    public static class Extensions {
        public static void AddUserLayer(this IServiceCollection services) {
            services.AddSingleton<UserRepository, UserRepository>();
            services.AddSingleton<UserService, UserService>();
        }

        public static void AddMovieLayer(this IServiceCollection services) {
            services.AddSingleton<MovieRepository, MovieRepository>();
            services.AddSingleton<MovieService, MovieService>();
        }
        
        public static void AddReservationLayer(this IServiceCollection services) {
            services.AddSingleton<ReservationRepository, ReservationRepository>();
            services.AddSingleton<ReservationService, ReservationService>();
        }
        
        public static void AddSeanceLayer(this IServiceCollection services) {
            services.AddSingleton<SeanceRepository, SeanceRepository>();
            services.AddSingleton<SeanceService, SeanceService>();
        }
        
        public static void AddCinemaHallLayer(this IServiceCollection services) {
            services.AddSingleton<CinemaHallRepository, CinemaHallRepository>();
            services.AddSingleton<CinemaHallService, CinemaHallService>();
        }
    }
}