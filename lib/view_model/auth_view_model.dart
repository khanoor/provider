import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/model/user_model.dart';
import 'package:provider_mvvm/repository/repository.dart';
import 'package:provider_mvvm/resources/app_url.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';
import 'package:provider_mvvm/view_model/user_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final _myrepo = Repository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.postApi(AppUrl.login, data).then((value) {
      setLoading(false);
      Utils.toastMessage('Login Successful');
      final userPreferance = Provider.of<UserViewModel>(context, listen: false);
      userPreferance.saveUser(UserModel(token: value['token'].toString()));
      Navigator.pushNamed(context, RoutesName.home);
      setLoading(false);
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
    _myrepo.postApi(AppUrl.register, data).then((value) {
      setRegsiterLoading(false);
      Utils.toastMessage('Register Successful');
      Navigator.pushNamed(context, RoutesName.home);
      setLoading(false);
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
