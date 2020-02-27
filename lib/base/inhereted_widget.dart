import 'package:flutter/widgets.dart';

class Globals extends InheritedWidget {
  const Globals({
    Key key,
    @required this.feedScrollController,
    @required Widget child,
  })  : assert(feedScrollController != null),
        assert(child != null),
        super(key: key, child: child);

  final ScrollController feedScrollController;

  static Globals of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Globals>();
  }

  @override
  bool updateShouldNotify(Globals old) => feedScrollController != old.feedScrollController;
}
