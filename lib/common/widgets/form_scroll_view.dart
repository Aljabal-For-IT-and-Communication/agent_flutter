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

  static VoidCallback? setDropdownSpace(BuildContext field, double height) {
    final state = field.findAncestorStateOfType<_FormScrollViewState>();
    if (state == null) return null;
    state._setDropdownSpace(field, height);
    return () {
      if (state.mounted) state._setDropdownSpace(field, 0);
    };
  }

  @override
  State<FormScrollView> createState() => _FormScrollViewState();
}

class _FormScrollViewState extends State<FormScrollView> {
  BuildContext? _dropdown;
  double _dropdownHeight = 0;

  void _setDropdownSpace(BuildContext field, double height) {
    if (height == 0 && _dropdown != field) return;
    setState(() {
      _dropdown = height == 0 ? null : field;
      _dropdownHeight = height;
    });
    if (height == 0) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !field.mounted || _dropdown != field) return;
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
      if (target > position.pixels) {
        position.animateTo(target,
            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    });
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
                top: false, child: SizedBox(height: 24 + _dropdownHeight)),
          ),
        ],
      ),
    );
    return widget.onRefresh == null
        ? scrollView
        : RefreshIndicator(onRefresh: widget.onRefresh!, child: scrollView);
  }
}
