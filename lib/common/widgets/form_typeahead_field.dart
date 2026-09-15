import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'form_scroll_view.dart';

/// A searchable dropdown that makes room in the form instead of opening upward.
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
  static const _listHeight = 240.0;
  VoidCallback? _releaseSpace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_updateSpace);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
    _updateSpace();
  }

  @override
  void didChangeMetrics() {
    // Scaffold removes keyboard insets from its body's MediaQuery, so observe
    // window changes and measure after the resized form has been laid out.
    _updateSpace();
  }

  void _updateSpace() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _releaseSpace = FormScrollView.setDropdownSpace(
        context,
        _focusNode.hasFocus ? _listHeight : 0,
      );
    });
  }

  @override
  void dispose() {
    final releaseSpace = _releaseSpace;
    WidgetsBinding.instance.addPostFrameCallback((_) => releaseSpace?.call());
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_updateSpace);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      focusNode: _focusNode,
      direction: VerticalDirection.down,
      autoFlipDirection: false,
      hideKeyboardOnDrag: false,
      constraints: const BoxConstraints(maxHeight: _listHeight),
      builder: widget.builder,
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: widget.itemBuilder,
      onSelected: widget.onSelected,
    );
  }
}
