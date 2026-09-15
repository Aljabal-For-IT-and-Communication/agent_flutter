import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'form_scroll_view.dart';

/// A searchable dropdown that makes room for its content below the field.
class FormTypeAheadField<T> extends StatefulWidget {
  const FormTypeAheadField({
    super.key,
    required this.builder,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSelected,
  });

  final Widget Function(BuildContext, TextEditingController, FocusNode) builder;
  final FutureOr<List<T>?> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final ValueChanged<T> onSelected;

  @override
  State<FormTypeAheadField<T>> createState() => _FormTypeAheadFieldState<T>();
}

class _FormTypeAheadFieldState<T> extends State<FormTypeAheadField<T>>
    with WidgetsBindingObserver {
  final _focusNode = FocusNode();
  final _suggestions = SuggestionsController<T>();
  static const _maxListHeight = 240.0;
  static const _settleDelay = Duration(milliseconds: 80);
  double _contentHeight = 0;
  bool _wasOpen = false;
  Timer? _settleTimer;
  VoidCallback? _releaseSpace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_scheduleSpace);
    _suggestions.addListener(_onSuggestionsChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
    _scheduleSpace();
  }

  @override
  void didChangeMetrics() => _scheduleSpace();

  void _onSuggestionsChanged() {
    if (_wasOpen == _suggestions.isOpen) return;
    _wasOpen = _suggestions.isOpen;
    _scheduleSpace();
  }

  void _scheduleSpace() {
    _settleTimer?.cancel();
    // Keyboard animation emits several metric changes. Wait for its final
    // viewport, then reveal the field and the measured list in one movement.
    _settleTimer = Timer(_settleDelay, () {
      if (!mounted) return;
      _releaseSpace = FormScrollView.setDropdownSpace(
        context,
        _focusNode.hasFocus ? (_suggestions.isOpen ? _contentHeight : 0) : null,
      );
    });
  }

  Widget _measureContent(Widget scrollView) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        if (notification.depth != 0) return false;
        final metrics = notification.metrics;
        // Include the clipped portion so a list near the keyboard reports its
        // natural content height, not just the tiny viewport currently visible.
        final height = (metrics.maxScrollExtent -
                metrics.minScrollExtent +
                metrics.viewportDimension)
            .clamp(0.0, _maxListHeight);
        if ((_contentHeight - height).abs() > 0.5) {
          _contentHeight = height;
          _scheduleSpace();
        }
        return false;
      },
      child: scrollView,
    );
  }

  Widget _message(BuildContext context, String text) {
    return _measureContent(SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
      ),
    ));
  }

  @override
  void dispose() {
    _settleTimer?.cancel();
    final releaseSpace = _releaseSpace;
    WidgetsBinding.instance.addPostFrameCallback((_) => releaseSpace?.call());
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_scheduleSpace);
    _focusNode.dispose();
    _suggestions.removeListener(_onSuggestionsChanged);
    _suggestions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      focusNode: _focusNode,
      suggestionsController: _suggestions,
      direction: VerticalDirection.down,
      autoFlipDirection: false,
      hideKeyboardOnDrag: false,
      // All current callers filter locally; avoid a delayed second adjustment.
      debounceDuration: Duration.zero,
      constraints: const BoxConstraints(maxHeight: _maxListHeight),
      builder: (context, controller, focusNode) => _CoordinatedReveal(
        onReveal: () {
          if (!focusNode.hasFocus ||
              context.findAncestorWidgetOfExactType<FormScrollView>() == null) {
            return false;
          }
          _scheduleSpace();
          return true;
        },
        child: widget.builder(context, controller, focusNode),
      ),
      // Observe the default lazy list instead of eagerly building every option
      // just to measure it. Its scroll metrics include content outside the box.
      decorationBuilder: (context, child) => Material(
        type: MaterialType.card,
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: _measureContent(child),
      ),
      emptyBuilder: (context) => _message(context, 'No items found!'),
      errorBuilder: (context, error) => _message(context, 'Error: $error'),
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: widget.itemBuilder,
      onSelected: widget.onSelected,
    );
  }
}

/// Let the form reveal the caret and dropdown together instead of letting the
/// TextField start a competing scroll just to reveal its caret.
class _CoordinatedReveal extends SingleChildRenderObjectWidget {
  const _CoordinatedReveal({required this.onReveal, required super.child});
  final bool Function() onReveal;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderCoordinatedReveal(onReveal);

  @override
  void updateRenderObject(
      BuildContext context, _RenderCoordinatedReveal renderObject) {
    renderObject.onReveal = onReveal;
  }
}

class _RenderCoordinatedReveal extends RenderProxyBox {
  _RenderCoordinatedReveal(this.onReveal);
  bool Function() onReveal;

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    if (!onReveal()) {
      super.showOnScreen(
          descendant: descendant, rect: rect, duration: duration, curve: curve);
    }
  }
}
