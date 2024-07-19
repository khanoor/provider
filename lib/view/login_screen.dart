import 'package:flutter/material.dart';
import 'package:provider_mvvm/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Column(
        children: [
          Center(
            child: IconButton(
                onPressed: () {
                  Utils.flushbarErrorMessage("message", context);
                  Utils.toastMessage("message");
                  Utils.snackBar("message", context);
                },
                icon: const Icon(
                  Icons.abc,
                  color: Colors.amber,
                )),
          )
        ],
      ),
    );
  }
}
