import 'package:provider_mvvm/data/network/base_api_services.dart';
import 'package:provider_mvvm/data/network/network_api_services.dart';
import 'package:provider_mvvm/resources/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.login, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> register(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.register, data);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
