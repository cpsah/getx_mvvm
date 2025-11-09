import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx_mvvm/data/app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print('Api Url : $url');
    }
    dynamic responseJson;

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException {
      throw InternetException('');
    }on RequestTimeoutException {
      throw RequestTimeoutException('');
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApi(String url, var data) async {
    if (kDebugMode) {
      print('Api Url : $url');
      print('Api Body : $data');
    }

    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException {
      throw InternetException('');
    }on RequestTimeoutException {
      throw RequestTimeoutException('');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
