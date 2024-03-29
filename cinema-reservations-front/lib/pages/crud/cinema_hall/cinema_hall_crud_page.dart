import 'package:cinema_reservations/app/app_drawer.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/app/theme.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class CinemaHallCrudPage extends StatefulWidget {
  const CinemaHallCrudPage({Key? key}) : super(key: key);

  @override
  _CinemaHallCrudPageState createState() => _CinemaHallCrudPageState();
}

class _CinemaHallCrudPageState extends State<CinemaHallCrudPage> {
  final _formKey = GlobalKey<FormState>();
  final _seatsController = TextEditingController();
  final _rowsController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Consumer<AppState>(builder: (context, state, _) => state.user?.role == Role.employee ? CustomDrawer.build(context) : Container()),
      appBar: CustomAppBar.build(context),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add new cinema hall',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 36),
                  TextFormField(
                    controller: _seatsController,
                    decoration: AppTheme.defaultTextInputStyle('Seats'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value cannot be empty';
                      }
                      try {
                        final result = int.parse(value);
                        if (result < 1 || result > 15) {
                          return 'Value must be between 1 and 15';
                        }
                      } catch (e) {
                        return 'Value must be a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _rowsController,
                    decoration: AppTheme.defaultTextInputStyle('Rows'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value cannot be empty';
                      }
                      try {
                        final result = int.parse(value);
                        if (result < 1 || result > 15) {
                          return 'Value must be between 1 and 15';
                        }
                      } catch (e) {
                        return 'Value must be a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _validateAndCreate(),
                    child: Text('Create'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndCreate() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    Provider.of<AppState>(context, listen: false).createCinemaHall(int.parse(_seatsController.text), int.parse(_rowsController.text));
    context.vRouter.to(Routes.main);
  }
}
