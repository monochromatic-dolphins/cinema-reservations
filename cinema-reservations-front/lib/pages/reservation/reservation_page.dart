import 'dart:math';

import 'package:cinema_reservations/app/colors.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/mocks.dart';
import 'package:cinema_reservations/model/reservation.dart';
import 'package:cinema_reservations/model/seance.dart';
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

  @override
  Widget build(BuildContext context) {
    final seanceId = context.vRouter.queryParameters['id'];
    final reservations =
        Mocks.reservations.where((reservation) => reservation.seance.id.toString() == seanceId).toList();

    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: SingleChildScrollView(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            final seance = state.seances.firstWhere((element) => element.id.toString() == seanceId);
            final seatsCount = seance.cinemaHall.seats * seance.cinemaHall.rows;
            if (_selectedSeats == null) _selectedSeats = _initSelectedSeats(seance, reservations);

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
                      '${seance.movie.title}, ${_formatDate(seance.startTime)}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 42),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: seance.cinemaHall.seats,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                      ),
                      itemCount: seatsCount,
                      itemBuilder: (context, index) {
                        final currentSeat = index % seance.cinemaHall.seats;
                        final currentRow = (index / seance.cinemaHall.seats).floor();

                        return InkWell(
                          onTap: () => _temporaryReservation(currentSeat, currentRow),
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
                      onPressed: () {},
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

  List<List<SeatState>> _initSelectedSeats(Seance seance, List<Reservation> reservations) {
    return List.generate(
      seance.cinemaHall.rows,
      (i) => List.generate(
        seance.cinemaHall.seats,
        (j) {
          if (reservations.firstWhereOrNull((res) => res.row == i && res.seat == j) != null) {
            return SeatState.reserved;
          }
          return SeatState.free;
        },
      ),
    );
  }

  String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy, hh:mm').format(date);

  void _temporaryReservation(int seat, row) {
    setState(() {
      switch (_selectedSeats![row][seat]) {
        case SeatState.free:
          _selectedSeats?[row][seat] = SeatState.selected;
          _seatsCount++;
          break;
        case SeatState.reserved:
          break;
        case SeatState.selected:
          _selectedSeats?[row][seat] = SeatState.free;
          _seatsCount--;
          break;
      }
    });
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
