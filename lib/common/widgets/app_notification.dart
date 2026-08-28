import 'dart:async';

import 'package:app/common/values/colors.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';

enum AppNotificationType { info, success, warning, error }

class AppNotification {
  const AppNotification._();

  static _NotificationEntry? _currentEntry;
  static VoidCallback? _pendingShow;
  static bool _retryScheduled = false;

  static void show({
    required String message,
    AppNotificationType type = AppNotificationType.info,
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    bool tryShow() {
      final overlay = Global.navigatorKey.currentState?.overlay;
      if (overlay == null || !overlay.mounted) return false;

      _pendingShow = null;
      dismiss();

      late final _NotificationEntry notificationEntry;
      final overlayEntry = OverlayEntry(
        builder: (context) => _NotificationOverlay(
          message: message,
          accentColor: _accentColor(type),
          backgroundColor: backgroundColor ?? Colors.white,
          textColor: textColor ?? AppColors.primaryText,
          icon: _icon(type),
          duration: duration ?? _duration(type),
          actionLabel: actionLabel,
          onAction: onAction,
          onDismiss: () => _remove(notificationEntry),
        ),
      );
      notificationEntry = _NotificationEntry(overlayEntry);
      _currentEntry = notificationEntry;
      overlay.insert(overlayEntry);
      return true;
    }

    if (tryShow()) return;

    _pendingShow = tryShow;
    if (_retryScheduled) return;
    _retryScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _retryScheduled = false;
      final pendingShow = _pendingShow;
      _pendingShow = null;
      pendingShow?.call();
    });
  }

  static void dismiss() {
    _pendingShow = null;
    final entry = _currentEntry;
    if (entry != null) _remove(entry);
  }

  static void _remove(_NotificationEntry entry) {
    if (_currentEntry == entry) {
      _currentEntry = null;
    }
    entry.remove();
  }

  static Color _accentColor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.info:
        return AppColors.primaryElement;
      case AppNotificationType.success:
        return AppColors.primarySuccess;
      case AppNotificationType.warning:
        return const Color(0xFFE09B00);
      case AppNotificationType.error:
        return AppColors.primaryError;
    }
  }

  static IconData _icon(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.info:
        return Icons.info_outline_rounded;
      case AppNotificationType.success:
        return Icons.check_circle_outline_rounded;
      case AppNotificationType.warning:
        return Icons.warning_amber_rounded;
      case AppNotificationType.error:
        return Icons.error_outline_rounded;
    }
  }

  static Duration _duration(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.success:
        return const Duration(seconds: 3);
      case AppNotificationType.info:
        return const Duration(seconds: 4);
      case AppNotificationType.warning:
        return const Duration(seconds: 5);
      case AppNotificationType.error:
        return const Duration(seconds: 7);
    }
  }
}

class _NotificationEntry {
  _NotificationEntry(this.overlayEntry);

  final OverlayEntry overlayEntry;
  bool _isRemoved = false;

  void remove() {
    if (_isRemoved) return;
    _isRemoved = true;
    overlayEntry
      ..remove()
      ..dispose();
  }
}

class _NotificationOverlay extends StatefulWidget {
  const _NotificationOverlay({
    required this.message,
    required this.accentColor,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.duration,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final Color accentColor;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Duration duration;
  final VoidCallback onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  State<_NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<_NotificationOverlay>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 220);

  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;
  Timer? _dismissTimer;
  bool? _accessibleNavigation;
  bool _disableAnimations = false;
  bool _didStartEntrance = false;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      reverseDuration: _animationDuration,
      vsync: this,
    );
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _opacity = animation;
    _position = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(animation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (!_didStartEntrance) {
      _didStartEntrance = true;
      _disableAnimations = disableAnimations;
      if (disableAnimations) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
    } else if (!_disableAnimations && disableAnimations) {
      _disableAnimations = true;
      _controller.value = 1;
    }

    final accessibleNavigation = MediaQuery.accessibleNavigationOf(context);
    if (_accessibleNavigation == accessibleNavigation) return;
    _accessibleNavigation = accessibleNavigation;
    _dismissTimer?.cancel();
    if (!accessibleNavigation || widget.onAction == null) {
      _dismissTimer = Timer(widget.duration, () {
        _dismiss();
      });
    }
  }

  Future<void> _dismiss() async {
    if (_isDismissing) return;
    _isDismissing = true;
    _dismissTimer?.cancel();
    if (!_disableAnimations) {
      try {
        await _controller.reverse().orCancel;
      } on TickerCanceled {
        return;
      }
    }
    if (!mounted) return;
    widget.onDismiss();
  }

  void _removeAfterSwipe() {
    _dismissTimer?.cancel();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Positioned.fill(
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: keyboardInset),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: SlideTransition(
                position: _position,
                child: FadeTransition(
                  opacity: _opacity,
                  child: Dismissible(
                    key: const ValueKey('app-notification'),
                    direction: DismissDirection.horizontal,
                    movementDuration: _disableAnimations
                        ? Duration.zero
                        : const Duration(milliseconds: 200),
                    resizeDuration: _disableAnimations
                        ? Duration.zero
                        : const Duration(milliseconds: 300),
                    onDismissed: (_) => _removeAfterSwipe(),
                    child: Material(
                      color: Colors.transparent,
                      child: _NotificationContent(
                        message: widget.message,
                        accentColor: widget.accentColor,
                        backgroundColor: widget.backgroundColor,
                        textColor: widget.textColor,
                        icon: widget.icon,
                        actionLabel: widget.actionLabel,
                        onAction: widget.onAction == null
                            ? null
                            : () {
                                if (_isDismissing) return;
                                _dismiss();
                                widget.onAction!();
                              },
                        onDismiss: () {
                          _dismiss();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.message,
    required this.accentColor,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final Color accentColor;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final VoidCallback onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final canShowAction = actionLabel != null && onAction != null;

    return Semantics(
      container: true,
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accentColor.withAlpha(70)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x24000000),
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 6, 10),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(24),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (canShowAction) ...[
                const SizedBox(width: 6),
                TextButton(
                  onPressed: onAction,
                  style: TextButton.styleFrom(foregroundColor: accentColor),
                  child: Text(actionLabel!),
                ),
              ],
              IconButton(
                onPressed: onDismiss,
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.close_rounded,
                  color: textColor.withAlpha(170),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
