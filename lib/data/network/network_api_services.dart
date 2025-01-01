import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider_mvvm/data/app_excaptions.dart';
import 'package:provider_mvvm/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body, String? token}) async {
    dynamic responseJson;
    try {
      var request = http.Request('GET', Uri.parse(url));

      // Add headers
      Map<String, String> finalHeaders = headers ?? {};
      if (token != null) {
        finalHeaders['Authorization'] = 'Bearer $token';
      }
      request.headers.addAll(finalHeaders);

      // Add body if provided
      if (body != null) {
        request.body = json.encode(body);
      }

      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 10));
      var response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data,
      {String? cookie, String? token}) async {
    dynamic responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (cookie != null) {
        headers["Cookie"] = "token=$cookie";
      }

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      Response response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJosn = jsonDecode(response.body);
        return responseJosn;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred on Http Request with status code ${response.statusCode}');
    }
  }
}
