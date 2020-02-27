import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

@immutable
class ConnectivityState {
  ConnectivityState({
    @required this.connectivityResult,
  });

  final ConnectivityResult connectivityResult;

  factory ConnectivityState.initial(ConnectivityResult connectivityResult) {
    return ConnectivityState(
      connectivityResult: connectivityResult ?? ConnectivityResult.none,
    );
  }

  ConnectivityState copyWith({ConnectivityResult connectivityResult}) {
    return ConnectivityState(
      connectivityResult: connectivityResult ?? this.connectivityResult,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectivityState &&
          runtimeType == other.runtimeType &&
          connectivityResult == other.connectivityResult;

  @override
  int get hashCode => connectivityResult.hashCode;
}
