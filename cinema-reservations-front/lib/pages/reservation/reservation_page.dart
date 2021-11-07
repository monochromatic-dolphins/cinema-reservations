import 'package:cinema_reservations/app/colors.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:cinema_reservations/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'package:collection/collection.dart';

enum SeatState { free, reserved, selected }

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<List<SeatState>>? _selectedSeats;
  int _seatsCount = 0;
  List<Reservation> _pendingReservations = [];

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).startFetching();
    runPostFrame(() async => Provider.of<AppState>(context, listen: false).fetchReservationPageData());
  }

  @override
  Widget build(BuildContext context) {
    final seanceId = context.vRouter.queryParameters['id'];

    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: SingleChildScrollView(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            if (state.isFetching) {
              print('loading');
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print('loaded');
            final seance = state.seances.firstWhere((element) => element.seanceId.toString() == seanceId);
            final reservations =
                state.reservations.where((reservation) => reservation.seance.seanceId.toString() == seanceId).toList();
            final seatsCount = seance.cinemaHall!.seats * seance.cinemaHall!.rows;
            if (_selectedSeats == null) _selectedSeats = _initSelectedSeats(seance, reservations, state.user!.userId);

            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Text(
                      'Reservation',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      '${seance.movie!.title}, ${_formatDate(seance.startTime)}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 42),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: seance.cinemaHall!.seats,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                      ),
                      itemCount: seatsCount,
                      itemBuilder: (context, index) {
                        final currentSeat = index % seance.cinemaHall!.seats;
                        final currentRow = (index / seance.cinemaHall!.seats).floor();

                        return InkWell(
                          onTap: () => _temporaryReservation(context, seance, currentSeat, currentRow),
                          child: Card(
                            color: _seatColor(currentSeat, currentRow),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  (index + 1).toString(),
                                  style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Price',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_seatsCount x 15 PLN = ${_seatsCount * 15} PLN',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _confirmReservation(context),
                      child: Text('Book tickets'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<List<SeatState>> _initSelectedSeats(
    Seance seance,
    List<Reservation> reservations,
    int userId,
  ) {
    return List.generate(
      seance.cinemaHall!.rows,
      (i) => List.generate(
        seance.cinemaHall!.seats,
        (j) {
          final r = reservations.firstWhereOrNull((res) => res.row == i && res.seat == j);
          if (r != null) {
            if (r.isTemporary && r.user.userId == userId) {
              return SeatState.selected;
            }
            return SeatState.reserved;
          }
          return SeatState.free;
        },
      ),
    );
  }

  String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy, hh:mm').format(date);

  void _temporaryReservation(BuildContext context, Seance seance, int seat, row) async {
    setState(() async {
      switch (_selectedSeats![row][seat]) {
        case SeatState.free:
          print('selecting');
          final result = await Provider.of<AppState>(context, listen: false).createReservation(seance, seat, row, true);
          if (result == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Something went wrong. Please refresh the page or try again later')),
            );
            return;
          }
          _pendingReservations.add(result);
          _selectedSeats?[row][seat] = SeatState.selected;
          _seatsCount++;
          break;
        case SeatState.reserved:
          print('reserved');
          break;
        case SeatState.selected:
          print('unselecting');
          final reservation = _pendingReservations
              .firstWhere((element) => element.seat == seat && element.row == row && element.seance == seance);
          await Provider.of<AppState>(context).deleteReservation(reservation);
          _selectedSeats?[row][seat] = SeatState.free;
          _seatsCount--;
          break;
      }
    });
  }

  void _confirmReservation(BuildContext context) async {
    for (var i = 0; i < _pendingReservations.length; i++) {
      final result = await Provider.of<AppState>(context, listen: false).confirmReservation(_pendingReservations[i]);
      if (!result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong. Please try again later')),
        );
        return;
      }
    }
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              contentPadding: EdgeInsets.all(25),
              title: Text(
                "Reservation finalized",
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                Text("Reservation confirmed. See you in the cinema!"),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text("Ok")),
              ],
            ));
  }

  Color _seatColor(int seat, row) {
    switch (_selectedSeats![row][seat]) {
      case SeatState.free:
        return Colors.deepPurple;
      case SeatState.reserved:
        return AppColors.red;
      case SeatState.selected:
        return AppColors.brightGreen;
    }
  }
}
