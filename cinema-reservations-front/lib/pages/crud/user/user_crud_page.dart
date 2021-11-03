import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCrudPage extends StatefulWidget {
  const UserCrudPage({Key? key}) : super(key: key);

  @override
  _UserCrudPageState createState() => _UserCrudPageState();
}

class _UserCrudPageState extends State<UserCrudPage> {

  @override
  Widget build(BuildContext context) {
    Provider.of<AppState>(context, listen: false).fetchUserCrudPageData();
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: Consumer<AppState>(
        builder: (context, state, _) => state.isFetching
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: Text(state.users[index].login),
                  onChanged: (val) {},
                  value: state.users[index].role == Role.employee,
                ),
              ),
      ),
    );
  }
}
