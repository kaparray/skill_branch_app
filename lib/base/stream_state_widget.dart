import 'package:flutter/widgets.dart';
import 'package:skill_branch_flutter/base/stream_request.dart';

typedef StreamBinder<T> = Widget Function(T param);

class StreamStateWidget<T> extends StatefulWidget {
  StreamStateWidget({
    @required this.request,
    this.dataWidget,
    this.progressWidget,
    this.animate = true,
  });

  final StreamRequest<T> request;

  final StreamBinder<T> dataWidget;
  final Widget progressWidget;

  final bool animate;

  @override
  StreamStateWidgetState<T> createState() {
    return StreamStateWidgetState<T>();
  }
}

class StreamStateWidgetState<T> extends State<StreamStateWidget<T>>
    with TickerProviderStateMixin {
  AnimationController _fadeController;

  @override
  void initState() {
    if (widget.animate) {
      _fadeController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 250));
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.animate) {
      _fadeController?.dispose();
    }

    super.dispose();
  }

  StreamData<T> _getInitialData() => widget.request.latestData();

  Widget _buildProgressWidget() {
    return widget.progressWidget == null
        ? Container()
        : (widget.progressWidget ?? Container());
  }

  Widget _buildDataWidget(T data) {
    return widget.dataWidget == null
        ? Container()
        : (widget.dataWidget(data) ?? Container());
  }

  Widget _buildContent(StreamData<T> data) {
    if (data == null || (data?.progress ?? false)) {
      return _buildProgressWidget();
    } else {
      return _buildDataWidget(data?.value?.result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StreamData<T>>(
      stream: widget.request.dataStream,
      initialData: _getInitialData(),
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.hasError) {
          return _buildDataWidget(null);
        }

        StreamData<T> data = snapshot?.data;

        if (!widget.animate) {
          return _buildContent(data);
        } else {
          _fadeController?.forward();

          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_fadeController),
            child: _buildContent(data),
          );
        }
      },
    );
  }
}
