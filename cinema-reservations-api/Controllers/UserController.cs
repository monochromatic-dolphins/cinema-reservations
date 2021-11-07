using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    public class UserController: ControllerBase {
        private readonly UserService _service;

        public UserController(UserService userService) {
            _service = userService;
        }

        [HttpGet]
        [Route("/users")]
        public IEnumerable<User> GetAllUsers() {
            return _service.GetAllUsers();
        }

        [HttpPost]
        [Route("/users")]
        public ActionResult<User> UpdateUser(User user) {
            var updatedUser = _service.UpdateUser(user);
            if (updatedUser != null) {
                return Ok(updatedUser);
            }

            return BadRequest();
        }

        [HttpPost]
        [Route("/login")]
        public ActionResult<LoginResponse> Login(LoginRequest loginRequest) {
            var loginResponse = _service.Login(loginRequest.Login, loginRequest.Password);
            if (loginResponse != null)
                return Ok(loginResponse);
            return Unauthorized();
        }

        [HttpPost]
        [Route("/register")]
        public ActionResult<LoginResponse> Register(LoginRequest loginRequest) {
            var registerResponse = _service.Register(loginRequest.Login, loginRequest.Password);
            if (registerResponse != null)
                return Ok(registerResponse);
            return BadRequest();
        }
    }
}