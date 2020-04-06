import 'dart:async';

import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/globals.dart';
import 'package:skill_branch_flutter/redux/states/app_state.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:http/http.dart' as http;

import 'base_bloc.dart';

const String kRateLimit = 'Rate Limit Exceeded';

enum RequestType { get, post, put, patch, delete }

abstract class BaseApi {
  AppState get state => store.state;

  String feedQueryParameters(int page, {int perPage}) => mapToQueryParameters({
        'photos': page,
        'per_page': perPage ?? kPerPageUserPhotos,
      });

  Map<String, String> get baseHeaders {
    Map<String, String> headers = {"Accept-Version": "v1"};
    var container = Container()<BaseConfig>();

    if (state.userState.credentialsState.isAuth)
      headers.addAll({"Authorization": "Bearer ${state.userState.credentialsState.userAccessToken}"});
    else
      headers.addAll({"Authorization": "Client-ID ${container.baseAccessKey}"});

    return headers;
  }

  Future<Response> makeRequest(String url,
      {RequestType type = RequestType.get, Duration duration = const Duration(seconds: 10), String overrideUrl}) async {
    Response response;
    var baseUrl = overrideUrl ?? Container()<BaseConfig>().baseUrl;

    switch (type) {
      case RequestType.get:
        response = await http
            .get(baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () => throw StreamError.timeoutError);
        break;
      case RequestType.put:
        response = await http
            .put(baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () => throw StreamError.timeoutError);
        break;
      case RequestType.post:
        response = await http
            .post(baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () => throw StreamError.timeoutError);
        break;
      case RequestType.delete:
        response = await http
            .delete(baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () => throw StreamError.timeoutError);
        break;
      case RequestType.patch:
        response = await http
            .patch(baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () => throw StreamError.timeoutError);
        break;
    }

    if (response.body == kRateLimit) {
      throw StreamError.rateLimit;
    }
    return response;
  }

  String mapToQueryParameters(Map<String, dynamic /*String|Iterable<String>*/ > queryParameters) {
    var result = StringBuffer();
    var separator = "";

    void writeParameter(String key, Object value) {
      result.write(separator);
      separator = "&";
      result.write(Uri.encodeQueryComponent(key));
      if (value != null && value != null) {
        result.write("=");
        result.write(Uri.encodeQueryComponent(value.toString()));
      }
    }

    queryParameters.forEach((key, value) {
      if (value == null || value is String || value is int) {
        writeParameter(key, value);
      } else {
        Iterable values = value;
        for (String value in values) {
          writeParameter(key, value);
        }
      }
    });

    return result.toString();
  }
}
