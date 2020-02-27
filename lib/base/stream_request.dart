import 'dart:async';

import 'package:connectivity/connectivity.dart';

typedef Future<T> FutureOperation<T>();

enum StreamRequestError {
  operationError,
  connectionError,
  serverError,
  timeoutError,
}

class RequestError {
  Object reason;
  int code;
  StreamRequestError errorType;

  RequestError(
    this.reason,
    this.code,
    this.errorType,
  );
}

class RequestResult<ItemType> {
  ItemType result;
  RequestError error;
  int code;

  RequestResult({
    this.result,
    this.error,
    this.code,
  });
}

class StreamData<T> {
  StreamData({this.value, this.progress = false, this.time});

  RequestResult<T> value;
  bool progress;
  DateTime time;
}

class StreamRequest<T> {
  StreamController<StreamData<T>> _streamController =
      StreamController<StreamData<T>>.broadcast();

  Stream<StreamData<T>> get dataStream =>
      _streamController.stream.asBroadcastStream();

  RequestResult _latestValue;
  StreamData<T> _latestData;

  Future<bool> _checkConnection() async {
    return await ConnectionUtils.checkConnection();
  }

  Future<RequestResult<T>> executeWithConnectionCheck(
      FutureOperation<RequestResult<T>> operation) async {
    var latest = latestValue();

    if (!await _checkConnection()) {
      _progress(
        RequestResult<T>(
          code: null,
          result: null,
          error: RequestError(null, null, StreamRequestError.connectionError),
        ),
        false,
      );
      return latest;
    }

    return await _executeWithLoadingIndication(operation);
  }

  Future<RequestResult<T>> execute(
      FutureOperation<RequestResult<T>> operation) async {
    return await _executeWithLoadingIndication(operation);
  }

  Future<RequestResult<T>> executeWithoutWidgetUpdate(
      FutureOperation<RequestResult<T>> operation) async {
    if (!await _checkConnection()) {
      return RequestResult<T>(
        code: null,
        result: null,
        error: RequestError(null, null, StreamRequestError.connectionError),
      );
    }

    try {
      return await operation();
    } catch (ex) {
      return RequestResult<T>(
        code: null,
        result: null,
        error: RequestError(null, null, StreamRequestError.operationError),
      );
    }
  }

  Future<RequestResult<T>> _executeWithLoadingIndication(
      FutureOperation<RequestResult<T>> operation) async {
    RequestResult<T> latest = latestValue();

    if (latest == null) {
      _progress(
        RequestResult(
          code: null,
          result: null,
          error: null,
        ),
        true,
      );
    }

    RequestResult<T> result;

    try {
      result = await operation();

      _progress(
        result,
        false,
      );

      return result ?? latest;
    } catch (ex) {
      _progress(
        RequestResult<T>(
          code: null,
          result: null,
          error: RequestError(null, null, StreamRequestError.operationError),
        ),
        false,
      );

      return latest;
    }
  }

  void _addToStreamSafe() {
    try {
      _streamController.add(_latestData);
    } catch (e) {
      // ignore
      // only should throw if data stream is very fast
      // so it won`t affect basic http or io streams
    }
  }

  void refresh() {
    _addToStreamSafe();
  }

  void _progress(RequestResult<T> value, bool progress) {
    _latestValue = value;

    _latestData =
        StreamData<T>(value: value, progress: progress, time: DateTime.now());

    _addToStreamSafe();
  }

  void goToProgress() {
    _latestData = StreamData<T>(
        value: _latestValue, progress: true, time: DateTime.now());

    _addToStreamSafe();
  }

  void addData(T data, {int code = 200}) {
    _latestValue = RequestResult<T>(
      result: data,
      error: null,
      code: code,
    );

    _latestData = StreamData<T>(
        value: _latestValue, progress: false, time: DateTime.now());

    _addToStreamSafe();
  }

  RequestResult<T> latestValue() {
    return _latestValue;
  }

  StreamData<T> latestData() {
    return _latestData;
  }

  bool hasData() {
    return _latestData != null;
  }

  bool inProgress() {
    return _latestData != null && _latestData.progress == true;
  }

  void dispose() {
    _streamController.close();
  }
}

class ConnectionUtils {
  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
