import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/app/theme.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/pages/auth/auth_page.dart';
import 'package:cinema_reservations/pages/crud/cinema_hall/cinema_hall_crud_page.dart';
import 'package:cinema_reservations/pages/crud/movie/movie_crud_page.dart';
import 'package:cinema_reservations/pages/crud/seance/seance_crud_page.dart';
import 'package:cinema_reservations/pages/crud/user/user_crud_page.dart';
import 'package:cinema_reservations/pages/home/home_page.dart';
import 'package:cinema_reservations/pages/reservation/reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _store = AppState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _store,
      child: Consumer<AppState>(
        builder: (context, state, _) => VRouter(
          title: 'Cinema Reservations',
          theme: AppTheme.mainTheme(context),
          initialUrl: Routes.main,
          routes: [
            VWidget(path: Routes.login, widget: AuthPage()),
            VGuard(
              beforeEnter: (vRedirector) async => _checkIfLoggedIn(vRedirector, state.isLoggedIn, state),
              stackedRoutes: [
                VWidget(path: Routes.main, widget: HomePage()),
                VWidget(path: Routes.reservation, widget: ReservationPage()),
                VGuard(
                    beforeEnter: (vRedirector) async =>
                    state.user?.role != Role.employee ? vRedirector.to(Routes.main) : null,
                    stackedRoutes: [
                      VWidget(path: Routes.crudCinemaHall, widget: CinemaHallCrudPage()),
                      VWidget(path: Routes.crudMovie, widget: MovieCrudPage()),
                      VWidget(path: Routes.crudSeance, widget: SeanceCrudPage()),
                      VWidget(path: Routes.crudUser, widget: UserCrudPage()),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _checkIfLoggedIn(VRedirector vRedirector, bool isLoggedIn, AppState state) async {
  final users = await state.users;
  print(users);
  if (!isLoggedIn) vRedirector.to(Routes.login);
}
