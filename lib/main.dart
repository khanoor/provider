import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/utils/routes/routes.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view_model/auth_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        initialRoute: RoutesName.login,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
