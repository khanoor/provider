import 'dart:io';

import 'package:provider_mvvm/data/network/base_api_services.dart';
import 'package:provider_mvvm/data/network/network_api_services.dart';

class Repository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getApi(String url, {String? token}) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(url, token: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postApi(String url, dynamic data,
      {String? token, File? file}) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(url, data,
          token: token, file: file);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
