import 'package:flutter/material.dart';

/// Scrolls forms inside a keyboard-resizing Scaffold and keeps their last
/// control clear of the bottom system inset. Do not add keyboard-height padding:
/// the Scaffold already removes that space from the viewport.
class FormScrollView extends CustomScrollView {
  FormScrollView({
    super.key,
    super.controller,
    super.physics,
    required List<Widget> slivers,
  }) : super(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            ...slivers,
            const SliverToBoxAdapter(
              child: SafeArea(top: false, child: SizedBox(height: 24)),
            ),
          ],
        );
}
