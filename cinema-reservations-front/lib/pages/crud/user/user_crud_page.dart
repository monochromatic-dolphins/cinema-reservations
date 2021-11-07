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
      drawer: Consumer<AppState>(
          builder: (context, state, _) => state.user?.role == Role.employee
              ? CustomDrawer.build(context)
              : Container()),
      appBar: CustomAppBar.build(context),
      body: Consumer<AppState>(
        builder: (context, state, _) => state.isFetching
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height  * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Users', style: Theme.of(context).textTheme.headline1,),
                      const SizedBox(height: 36),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Employee',
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(
                              state.users[index].login,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            onChanged: (val) =>
                                state.changeUserRole(state.users[index]),
                            value: state.users[index].role == Role.employee,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
