import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/data/response/status.dart';
import 'package:provider_mvvm/resources/color.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view_model/home_view_model.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMovie();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  userPreference.remove().then((value) {
                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.login,
                        (route) {
                      return false;
                    });
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(color: AppColor.whiteColor),
                  ),
                ))
          ],
        ),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => homeViewModel,
          child: Consumer<HomeViewModel>(builder: (context, value, _) {
            switch (value.movieList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Text(value.movieList.message.toString());
              case Status.COMPLETED:
                return Column(
                  children: [Text(value.movieList.data!.awards.toString())],
                );
              default:
                return Container();
            }
          }),
        ));
  }
}
