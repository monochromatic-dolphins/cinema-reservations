import 'package:cinema_reservations/app/colors.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/pages/home/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              'Movies',
              style: Theme.of(context).textTheme.headline1,
            ),
            Consumer<AppState>(
              builder: (context, state, _) => Expanded(
                child: ListView.separated(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) => MovieTile(
                    movie: state.movies[index],
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      // color: AppColors.divider,
                      thickness: 1,
                      height: 1,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
