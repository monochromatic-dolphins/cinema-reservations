using System.ComponentModel.DataAnnotations;

namespace cinema_reservations_api.Model {
    public class User {
        public int UserId { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
    }
}