import 'package:cinema_reservations/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CustomDrawer {
  static Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Add movie'),
            onTap: () => context.vRouter.to(Routes.crudMovie),
          ),
          ListTile(
            title: Text('Add cinema hall'),
            onTap: () => context.vRouter.to(Routes.crudCinemaHall),
          ),
          ListTile(
            title: Text('Add seance'),
            onTap: () => context.vRouter.to(Routes.crudSeance),
          ),
          ListTile(
            title: Text('Manage users'),
            onTap: () => context.vRouter.to(Routes.crudUser),
          ),
        ],
      ),
    );
  }
}