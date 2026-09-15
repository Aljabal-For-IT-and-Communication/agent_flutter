import 'package:flutter/material.dart';

/// Scrolls forms inside a keyboard-resizing Scaffold and keeps their last
/// control clear of the bottom system inset. Do not add keyboard-height padding:
/// the Scaffold already removes that space from the viewport.
class FormScrollView extends StatefulWidget {
  const FormScrollView({
    super.key,
    this.controller,
    this.physics,
    this.onRefresh,
    required this.slivers,
  });

  final ScrollController? controller;
  final ScrollPhysics? physics;
  final List<Widget> slivers;
  final Future<void> Function()? onRefresh;

  static VoidCallback? setDropdownSpace(BuildContext field, double? height) {
    final state = field.findAncestorStateOfType<_FormScrollViewState>();
    if (state == null) return null;
    state._setDropdownSpace(field, height);
    return () {
      if (state.mounted) state._setDropdownSpace(field, null);
    };
  }

  @override
  State<FormScrollView> createState() => _FormScrollViewState();
}

class _FormScrollViewState extends State<FormScrollView> {
  BuildContext? _dropdown;
  double _dropdownHeight = 0;
  Duration _paddingDuration = Duration.zero;
  double? _scrollTarget;
  int _layoutVersion = 0;

  void _setDropdownSpace(BuildContext field, double? height) {
    if (height == null && _dropdown != field) return;
    final version = ++_layoutVersion;
    _dropdown = height == null ? null : field;
    final padding = height ?? 0;
    if ((_dropdownHeight - padding).abs() > 0.5) {
      setState(() {
        // Grow immediately so the complete target is available for one scroll;
        // collapse gently so a shorter result list cannot jerk the viewport.
        _paddingDuration = padding < _dropdownHeight
            ? const Duration(milliseconds: 200)
            : Duration.zero;
        _dropdownHeight = padding;
      });
    }
    if (height == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted ||
          !field.mounted ||
          _dropdown != field ||
          version != _layoutVersion) {
        return;
      }
      final viewport = context.findRenderObject()! as RenderBox;
      final input = field.findRenderObject()! as RenderBox;
      final position = Scrollable.of(field).position;
      final top = input.localToGlobal(Offset.zero, ancestor: viewport).dy;
      // Keep the field visible even in a short landscape viewport. The list
      // itself can scroll when there is less than its preferred height.
      final missing =
          top + input.size.height + height + 8 - viewport.size.height;
      final delta = missing.clamp(0.0, top.clamp(0.0, double.infinity));
      final target = (position.pixels + delta)
          .clamp(position.minScrollExtent, position.maxScrollExtent);
      if (target > position.pixels + 0.5 &&
          (_scrollTarget == null || (_scrollTarget! - target).abs() > 0.5)) {
        _scrollTarget = target;
        position
            .animateTo(target,
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic)
            .whenComplete(() {
          if (_scrollTarget == target) _scrollTarget = null;
        });
      }
    });
    // A repeated request may need a new viewport measurement without a rebuild.
    WidgetsBinding.instance.ensureVisualUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final scrollView = NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        // Dropdown overlays also bubble scroll updates through the form.
        // Only a drag in this viewport should dismiss the keyboard.
        if (notification.depth == 0 && notification.dragDetails != null) {
          final scope = FocusScope.of(context);
          if (!scope.hasPrimaryFocus && scope.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        }
        return false;
      },
      child: CustomScrollView(
        controller: widget.controller,
        physics: widget.onRefresh == null
            ? widget.physics
            : AlwaysScrollableScrollPhysics(parent: widget.physics),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        slivers: [
          ...widget.slivers,
          SliverToBoxAdapter(
            child: SafeArea(
                top: false,
                child: AnimatedContainer(
                  duration: _paddingDuration,
                  curve: Curves.easeOutCubic,
                  height: 24 + _dropdownHeight,
                )),
          ),
        ],
      ),
    );
    return widget.onRefresh == null
        ? scrollView
        : RefreshIndicator(onRefresh: widget.onRefresh!, child: scrollView);
  }
}
