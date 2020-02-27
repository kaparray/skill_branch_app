import 'package:flutter/widgets.dart';

@immutable
class TabState {
  TabState({
    @required this.currentTab,
  });

  final int currentTab;

  factory TabState.initial({int currentTab}) {
    return TabState(
      currentTab: currentTab ?? 0,
    );
  }

  TabState copyWith({int currentTab}) {
    return TabState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabState &&
          runtimeType == other.runtimeType &&
          currentTab == other.currentTab;

  @override
  int get hashCode => currentTab.hashCode;
}
