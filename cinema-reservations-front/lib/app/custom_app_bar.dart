import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class CustomAppBar {
  static AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'Best Cinema',
        style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white, fontSize: 36),
      ),
      leading: Icon(Icons.movie),
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          onPressed: () => context.vRouter.to(Routes.main),
          icon: Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {
            Provider.of<AppState>(context, listen: false).logOut();
            context.vRouter.to(Routes.login);
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
