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
          .fetchUserCrudPageData()
          .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final res = (obj as DioError).response;
            print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
            break;
          default:
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: Consumer<AppState>(
        builder: (context, state, _) => state.isFetching
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: Text(state.users[index].login),
                  onChanged: (val) => state.changeUserRole(state.users[index]),
                  value: state.users[index].role == Role.employee,
                ),
              ),
      ),
    );
  }
}
