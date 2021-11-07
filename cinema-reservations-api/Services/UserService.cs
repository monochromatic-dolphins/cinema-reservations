using System.Collections.Generic;
using cinema_reservations_api.Cryptography;
using cinema_reservations_api.Model;
using cinema_reservations_api.Repository;

namespace cinema_reservations_api.Services {
    public class UserService {
        private readonly UserRepository _repository;

        public UserService(UserRepository userRepository) {
            _repository = userRepository;
        }

        public IEnumerable<User> GetAllUsers() {
            return _repository.GetAllUsers();
        }

        public LoginResponse Login(string login, string password) {
            var codedPassword = CaesarCipher.Encode(password);
            var user = _repository.Login(login, codedPassword);
            return user != null ? new LoginResponse(user.UserId, user.Role) : null;
        }

        public LoginResponse Register(string login, string password) {
            var codedPassword = CaesarCipher.Encode(password);
            var user = _repository.Register(login, codedPassword);
            return user != null ? new LoginResponse(user.UserId, user.Role) : null;
        }

        public User UpdateUser(User user) {
            var updatedUser = _repository.UpdateUser(user);
            return updatedUser;
        }
    }
}