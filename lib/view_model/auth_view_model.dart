import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/repository/auth_repository.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';

class AuthViewModel extends ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.login(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Login Successful');
      Navigator.pushNamed(context, RoutesName.home);
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError(
      (error, stackTrace) {
        setLoading(false);
        Utils.flushbarErrorMessage('Login Failed', context);
        if (kDebugMode) {
          print(error);
        }
      },
    );
  }

  bool _registerloading = false;
  bool get registerLoading => _registerloading;
  setRegsiterLoading(value) {
    _registerloading = value;
    notifyListeners();
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setRegsiterLoading(true);
    _myrepo.register(data).then((value) {
      setRegsiterLoading(false);
      Utils.toastMessage('Register Successful');
      Navigator.pushNamed(context, RoutesName.home);
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError(
      (error, stackTrace) {
        setRegsiterLoading(false);
        Utils.flushbarErrorMessage('Register Failed', context);
        if (kDebugMode) {
          print(error);
        }
      },
    );
  }
}
