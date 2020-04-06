import 'package:skill_branch_flutter/redux/states/app_state.dart';
import 'package:skill_branch_flutter/redux/store.dart';

abstract class BaseBloc {
  AppState get state => store.state;

  void init();
  void dispose() {}
}

class StreamData<T> {
  StreamData({
    this.statusCode,
    this.inProgress = false,
    this.data,
    this.error,
  });

  final int statusCode;
  final bool inProgress;
  final T data;
  final StreamError error;
}

enum StreamError {
  connectionError,
  operationError,
  timeoutError,
  accessTokenInvalid,
  rateLimit,
}
