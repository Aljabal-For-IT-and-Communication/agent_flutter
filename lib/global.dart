import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:app/common/routes/BlocEventStateObserver.dart';
import 'package:app/common/services/storage.dart';
import 'package:app/common/utils/loading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

class Global {
  static late StorageService storageService;
  static late EventBus eventBus;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static Future init() async {
    initializeDateFormatting();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setSystemUi();
    eventBus = EventBus();
    await GetStorage.init();
    Bloc.observer = BlocEventStateObserver();
    Loading();
    storageService = await StorageService().init();
  }

  static TransitionBuilder MaterialAppBuilder({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      final safeAreaChild = _AndroidSystemNavigationSafeArea(
        child: child ?? const SizedBox.shrink(),
      );
      final keyboardDismissChild = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: safeAreaChild,
      );

      if (builder != null) {
        return builder(
            context,
            Overlay(initialEntries: [
              OverlayEntry(builder: (BuildContext context) {
                return FlutterEasyLoading(
                  key: GlobalKey(),
                  child: keyboardDismissChild,
                );
              }),
            ]));
      } else {
        return Overlay(initialEntries: [
          OverlayEntry(builder: (BuildContext context) {
            return FlutterEasyLoading(
              key: GlobalKey(),
              child: keyboardDismissChild,
            );
          }),
        ]);
      }
    };
  }

  static void setSystemUi() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

class _AndroidSystemNavigationSafeArea extends StatelessWidget {
  const _AndroidSystemNavigationSafeArea({
    required this.child,
  });

  static const double _buttonNavigationInsetThreshold = 32;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final hasButtonNavigationBar =
        Platform.isAndroid && bottomInset >= _buttonNavigationInsetThreshold;

    if (!hasButtonNavigationBar) {
      return child;
    }

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: child,
    );
  }
}
