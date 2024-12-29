import 'package:provider_mvvm/data/network/base_api_services.dart';
import 'package:provider_mvvm/data/network/network_api_services.dart';

class Repository{

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getApi(dynamic url) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postApi(dynamic url, dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(url, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}