import 'package:cinema_reservations/app/app_drawer.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/utils/helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCrudPage extends StatefulWidget {
  const UserCrudPage({Key? key}) : super(key: key);

  @override
  _UserCrudPageState createState() => _UserCrudPageState();
}

class _UserCrudPageState extends State<UserCrudPage> {

  @override
  void initState() {
    super.initState();
    runPostFrame(() async {
      await Provider.of<AppState>(context, listen: false)
          .fetchUserCrudPageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Consumer<AppState>(builder: (context, state, _) => state.user?.role == Role.employee ? CustomDrawer.build(context) : Container()),
      appBar: CustomAppBar.build(context),
      body: Consumer<AppState>(
        builder: (context, state, _) => state.isFetching
            ? Center(child: CircularProgressIndicator())
            : Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) => CheckboxListTile(
                      title: Text(state.users[index].login, style: Theme.of(context).textTheme.headline3,),
                      onChanged: (val) => state.changeUserRole(state.users[index]),
                      value: state.users[index].role == Role.employee,
                    ),
                  ),
              ),
            ),
      ),
    );
  }
}
