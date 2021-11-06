import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/cinema_hall.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/utils/helpers.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    runPostFrame(() async => Provider.of<AppState>(context, listen: false)
        .fetchSeanceCrudPageData());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar.build(context),
        body: Consumer<AppState>(
          builder: (context, state, _) => state.isFetching
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Form(
                        key: _formKey,
                        child: Column(
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
        ),
      );

  void _validateAndCreate() {
    if (_formKey.currentState?.validate() == false ||
        _selectedHall == null ||
        _selectedMovie == null) {
      return;
    }
    Provider.of<AppState>(context, listen: false)
        .createSeance(_selectedHall!, _selectedMovie!, _selectedDate);
  }
}
