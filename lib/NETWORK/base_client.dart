import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../UTILS/consts.dart';
import '../UTILS/dialog_helper.dart';
import '../UTILS/utils.dart';
import 'app_exceptions.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  static const String e = "AIzaSy";
  static const String f = "AiGUD";
  static const String g = "fOoN";
  static const String a = e + f + g;
  static const String b = "7UeUxt_V";
  static const String c = "bOdFuv";
  static const String d = "oBM2J4614Q";
  //static const String baseUrl = 'https://appfish.infinitysoftsystems.in/api/';
  static const String baseUrl = 'http://13.50.224.176/api/';

  //GET
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(baseUrl + api);
    String? authKey = await Utility.getStringValue(authTokenKey);
    try {
      var response = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Authorization": authKey == null ? "" : "Bearer $authKey",
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      DialogHelper.showErrorDialog(description: 'Oops! No Internet connection');
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      DialogHelper.showErrorDialog(
          description: 'Oops! API not responded in time');
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic>? post(String api, dynamic payloadObj) async {
    //print("==============$payloadObj");
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    String? authKey = await Utility.getStringValue(authTokenKey);
    try {
      var response = await http
          .post(uri,
              headers: {
                "Accept": "application/json",
                "Authorization": authKey == null ? "" : "Bearer $authKey",
                "Content-Type": "application/json",
              },
              body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  //OTHER
  dynamic _processResponse(http.Response response) {
    //print('API  ======${response.request?.url} \nResponse ========${response.body}');
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
      case 204:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
