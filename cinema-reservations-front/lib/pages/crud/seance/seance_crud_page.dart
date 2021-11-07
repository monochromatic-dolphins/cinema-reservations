import 'package:cinema_reservations/app/app_drawer.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/utils/helpers.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class SeanceCrudPage extends StatefulWidget {
  const SeanceCrudPage({Key? key}) : super(key: key);

  @override
  _SeanceCrudPageState createState() => _SeanceCrudPageState();
}

class _SeanceCrudPageState extends State<SeanceCrudPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  CinemaHall? _selectedHall;
  Movie? _selectedMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppState>(context, listen: false).startFetching();
    runPostFrame(() async => Provider.of<AppState>(context, listen: false)
        .fetchSeanceCrudPageData());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: Consumer<AppState>(builder: (context, state, _) => state.user?.role == Role.employee ? CustomDrawer.build(context) : Container()),
        appBar: CustomAppBar.build(context),
        body: Consumer<AppState>(
          builder: (context, state, _) => state.isFetching
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height  * 0.9,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add new seance',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const SizedBox(height: 36),
                            DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              initialValue: '',
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                              dateLabelText: 'Start time',
                              onSaved: (val) => val != null
                                  ? _selectedDate = DateTime.parse(val)
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            DropdownButton(
                              items: state.movies
                                  .map(
                                    (movie) => DropdownMenuItem<Movie>(
                                      child: Text(movie.title),
                                      value: movie,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (Movie? value) => setState(() {
                                _selectedMovie = value;
                              }),
                              value: _selectedMovie,
                              hint: Text('Select movie'),
                              isExpanded: true,
                            ),
                            const SizedBox(height: 12),
                            DropdownButton(
                              items: state.cinemaHalls
                                  .map(
                                    (hall) => DropdownMenuItem<CinemaHall>(
                                      value: hall,
                                      child: Text('Hall ${hall.cinemaHallId}'),
                                    ),
                                  )
                                  .toList(),
                              value: _selectedHall,
                              onChanged: (CinemaHall? value) => setState(() {
                                _selectedHall = value;
                              }),
                              hint: Text('Select hall'),
                              isExpanded: true,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => _validateAndCreate(context),
                              child: Text('Create'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      );

  void _validateAndCreate(BuildContext context) async {
    if (_formKey.currentState?.validate() == false ||
        _selectedHall == null ||
        _selectedMovie == null) {
      return;
    }
    context.vRouter.to(Routes.main);
    Provider.of<AppState>(context, listen: false)
        .createSeance(_selectedHall!, _selectedMovie!, _selectedDate);
  }
}
