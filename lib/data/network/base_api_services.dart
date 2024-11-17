import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url,
      {Map<String, String>? headers, Map<String, String>? body});
  Future<dynamic> getPostApiResponse(String url, dynamic data, {String cookie});
}
