import 'package:cinema_reservations/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CustomDrawer {
  static Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 24),
          Text('Menu', style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center,),
          const SizedBox(height: 24),
          ListTile(
            title: Text('Add movie', style: Theme.of(context).textTheme.headline3,),
            onTap: () => context.vRouter.to(Routes.crudMovie),
          ),
          ListTile(
            title: Text('Add cinema hall', style: Theme.of(context).textTheme.headline3,),
            onTap: () => context.vRouter.to(Routes.crudCinemaHall),
          ),
          ListTile(
            title: Text('Add seance', style: Theme.of(context).textTheme.headline3,),
            onTap: () => context.vRouter.to(Routes.crudSeance),
          ),
          ListTile(
            title: Text('Manage users', style: Theme.of(context).textTheme.headline3,),
            onTap: () => context.vRouter.to(Routes.crudUser),
          ),
        ],
      ),
    );
  }
}