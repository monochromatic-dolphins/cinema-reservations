import 'package:cinema_reservations/app/app_drawer.dart';
import 'package:cinema_reservations/app/colors.dart';
import 'package:cinema_reservations/app/custom_app_bar.dart';
import 'package:cinema_reservations/model/app_state.dart';
import 'package:cinema_reservations/model/user.dart';
import 'package:cinema_reservations/pages/home/movie_tile.dart';
import 'package:cinema_reservations/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    runPostFrame(() async => Provider.of<AppState>(context, listen: false).fetchHomePageData());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Consumer<AppState>(builder: (context, state, _) => state.user?.role == Role.employee ? CustomDrawer.build(context) : Container()),
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
                builder: (context, state, _) => state.isFetching
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
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
