import 'package:cinema_reservations/app/colors.dart';
import 'package:cinema_reservations/app/routes.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/movie.dart';
import 'package:cinema_reservations/model/seance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final seances = state.seances.where((seance) => seance.movie == movie).toList()
          ..sort((a, b) => a.startTime.compareTo(b.startTime));
        final width = MediaQuery.of(context).size.width;
        final rows = width ~/ 250;

        return Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text('Duration: ${movie.duration}'),
              SizedBox(height: 10),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rows,
                  childAspectRatio: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: seances.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _navigateToReservationPage(context, seances[index]),
                    child: Card(
                      color: Colors.deepPurple,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _formatDate(seances[index].startTime),
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy, hh:mm').format(date);

  void _navigateToReservationPage(BuildContext context, Seance seance) {
    context.vRouter.to(Routes.reservation, queryParameters: {
      'id': seance.id.toString(),
    });
  }
}
