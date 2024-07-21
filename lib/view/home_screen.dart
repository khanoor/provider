import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Center(
          child: InkWell(
              onTap: () {
                userPreference.remove().then((value) {
                  Navigator.pushNamedAndRemoveUntil(context, RoutesName.login,
                      (route) {
                    return false;
                  });
                });
              },
              child: const Text("Logout"))),
    );
  }
}
