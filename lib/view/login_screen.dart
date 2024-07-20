import 'package:flutter/material.dart';
import 'package:provider_mvvm/resources/components/round_button.dart';
import 'package:provider_mvvm/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
FocusNode _emailFocus = FocusNode();
FocusNode _passwordFocus = FocusNode();
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  _emailFocus.dispose();
  _passwordFocus.dispose();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocus,
              decoration: const InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.alternate_email)),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(context, _emailFocus, _passwordFocus);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocus,
                    obscureText: _obsecurePassword.value,
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility))),
                  );
                }),
            const SizedBox(height: 15),
            RoundButton(
              title: 'Login',
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  Utils.snackBar("Please enter email", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.snackBar("Please enter password", context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushbarErrorMessage(
                      "Please enter 6 digits password", context);
                } else {
                  Utils.toastMessage(
                    "Login Successfully",
                  );
                }
              },
              loading: false,
            )
          ],
        ),
      ),
    );
  }
}
