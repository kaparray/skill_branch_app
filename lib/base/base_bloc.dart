import 'package:skill_branch_flutter/redux/app/app_state.dart';
import 'package:skill_branch_flutter/redux/store.dart';

abstract class BaseBloc {
  AppState get state => store.state;
  Object dispatch(Object action) => store.dispatch(action);

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
