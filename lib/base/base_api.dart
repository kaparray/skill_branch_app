import 'dart:async';

import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:skill_branch_flutter/di/injector.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/store.dart';
import 'package:skill_branch_flutter/static.dart';
import 'package:http/http.dart' as http;

import 'base_bloc.dart';

const String kRateLimit = 'Rate Limit Exceeded';

enum RequestType { get, post, put, patch, delete }

abstract class BaseApi {
  AppState get state => store.state;
  Object dispatch(Object action) => store.dispatch(action);

  String feedQueryParametrs(int page, {int perPage}) => mapToQueryParametrs({
        'photos': page,
        'per_page': perPage ?? kPerPageUserPhotos,
      });

  Map<String, String> get baseHeaders {
    Map<String, String> headers = {"Accept-Version": "v1"};
    var container = Container()<BaseConfig>();

    if (state.userState.isAuth)
      headers.addAll({"Authorization": "Bearer ${state.userState.userAccessToken}"});
    else
      headers.addAll({"Authorization": "Client-ID ${container.baseAccessKey}"});

    return headers;
  }

  Future<Response> makeRequest(String url, {RequestType type = RequestType.get,
      Duration duration = const Duration(seconds: 10), String overrideUrl}) async {
    Response response;
    var container = Container()<BaseConfig>();


    switch (type) {
      case RequestType.get:
        response = await http
            .get(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.put:
        response = await http
            .put(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.post:
      print(container.baseUrl + url);
        response = await http
            .post(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.delete:
        response = await http
            .delete(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.patch:
        response = await http
            .patch(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
    }

    if (response.body == kRateLimit) {
      throw StreamError.rateLimit;
    }
    return response;
  }

  String mapToQueryParametrs(
      Map<String, dynamic /*String|Iterable<String>*/ > queryParameters) {
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


  String mapToQueryParametrs(
      Map<String, dynamic /*String|Iterable<String>*/ > queryParameters) {
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

  Future<Response> makeRequest(String url, {RequestType type = RequestType.get,
      Duration duration = const Duration(seconds: 10), String overrideUrl}) async {
    Response response;
    var container = Container()<BaseConfig>();

    switch (type) {
      case RequestType.get:
        response = await http
            .get(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.put:
        response = await http
            .put(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.post:
      print(container.baseUrl + url);
        response = await http
            .post(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.delete:
        response = await http
            .delete(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
      case RequestType.patch:
        response = await http
            .patch(container.baseUrl + url, headers: baseHeaders)
            .timeout(duration, onTimeout: () {
          throw StreamError.timeoutError;
        });
        break;
    }

    if (response.body == kRateLimit) {
      throw StreamError.rateLimit;
    }
    return response;
  }

    Map<String, String> get baseHeaders {
    Map<String, String> headers = {"Accept-Version": "v1"};
    var container = Container()<BaseConfig>();


    if (state.userState.isAuth)
      headers.addAll({"Authorization": "Bearer ${state.userState.userAccessToken}"});
    else
      headers.addAll({"Authorization": "Client-ID ${container.baseAccessKey}"});

    return headers;
  }
    AppState get state => store.state;
