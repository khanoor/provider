import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/resources/components/round_button.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
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

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SignUp"),
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
            SizedBox(height: height * .05),
            RoundButton(
              loading: authViewModel.registerLoading,
              title: 'SignUp',
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  Utils.snackBar("Please enter email", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.snackBar("Please enter password", context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushbarErrorMessage(
                      "Please enter 6 digits password", context);
                } else {
                  Map data = {
                    "email": _emailController.text.toString(),
                    "password": _passwordController.text.toString()
                  };
                  authViewModel.signupApi(data, context);
                }
              },
            ),
            const SizedBox(height: 10),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text('Already have account...')),
          ],
        ),
      ),
    );
  }
}
