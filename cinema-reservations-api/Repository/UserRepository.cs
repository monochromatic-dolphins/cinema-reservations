using System.Collections.Generic;
using System.Linq;
using cinema_reservations_api.DbContexts;
using cinema_reservations_api.Model;
using Microsoft.Extensions.DependencyInjection;

namespace cinema_reservations_api.Repository {
    public class UserRepository {
        private readonly IServiceScopeFactory _scopeFactory;

        public UserRepository(IServiceScopeFactory scopeFactory) {
            _scopeFactory = scopeFactory;
        }

        public IEnumerable<User> GetAllUsers() {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.Users.ToList();
        }

        public User Login(string login, string password) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.Users
                .Where(user => user.Login == login)
                .SingleOrDefault(user => user.Password == password);
        }

        public User Register(string login, string codedPassword) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            return db.Users
                .Add(
                    new User {
                        UserId = 0,
                        Login = login,
                        Password = codedPassword,
                        Role = "USER"
                    }
                ).Entity;
        }

        public User UpdateUser(User user) {
            using var scope = _scopeFactory.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<InMemoryDbContext>();
            var dbUser = db.Users.Find(user.UserId);
            dbUser.Role = user.Role;
            var updatedUser = db.Users.Update(dbUser).Entity;
            db.SaveChanges();
            return updatedUser;
        }
    }
}