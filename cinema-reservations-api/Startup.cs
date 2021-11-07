using cinema_reservations_api.DbContexts;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;

namespace cinema_reservations_api {
    public class Startup {
        public Startup(IConfiguration configuration) {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services) {
            services.AddCors(o => o.AddPolicy("MyPolicy", builder =>
            {
                builder.AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader();
            }));

            services.AddControllers();
            services.AddDbContext<InMemoryDbContext>(opt => opt.UseInMemoryDatabase("cinema-reservations"));
            InitializeModelClasses(services);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env) {
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage(); 
            }
            app.UseCors("MyPolicy");
            
            app.UseRouting();
            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
            var scope = app.ApplicationServices.CreateScope();
            var context = scope.ServiceProvider.GetService<InMemoryDbContext>();
            DataInitializer.InitializeData(context);
        }

        private static void InitializeModelClasses(IServiceCollection services) {
            services.AddUserLayer();
            services.AddMovieLayer();
            services.AddCinemaHallLayer();
            services.AddSeanceLayer();
            services.AddReservationLayer();
        }
    }
}