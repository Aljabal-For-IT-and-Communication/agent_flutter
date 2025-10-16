import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/routes/routes.dart';
import 'package:app/common/style/theme.dart';
import 'package:app/global.dart';
import 'package:easy_localization/easy_localization.dart';

import 'common/utils/FirebaseMassagingHandler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Global.init();
  var language = Global.storageService.getLanguage();
  Locale defaultLocale = Locale('en');
  if (language == "") {
    // 获取设备的语言环境
    final deviceLocale = WidgetsBinding.instance.window.locale;
    // 如果设备语言是阿拉伯语（'ar'），则使用阿拉伯语；否则使用英语
    defaultLocale =
        deviceLocale.languageCode == 'ar' ? Locale('ar') : Locale('en');
  } else {
    defaultLocale = language == 'ar' ? Locale('ar') : Locale('en');
  }
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'), // 回退语言为英语
      startLocale: defaultLocale, // 根据设备语言设置默认语言
      child: MyApp(),
    ),
  );
  firebaseInit().whenComplete(() {
    FirebaseMassagingHandler.config();
  });
}

Future firebaseInit() async {
  FirebaseMessaging.onBackgroundMessage(
    FirebaseMassagingHandler.firebaseMessagingBackground,
  );
  if (Platform.isAndroid) {
    FirebaseMassagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMassagingHandler.channel_message);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [...AppPages.Blocer(context)],
        child: ScreenUtilInit(
            designSize: Size(375, 812),
            builder: (context, child) => MaterialApp(
                  title: 'Alafdal+Agents',
                  theme: AppTheme.light,
                  navigatorKey: Global.navigatorKey,
                  scaffoldMessengerKey: Global.rootScaffoldMessengerKey,
                  builder: Global.MaterialAppBuilder(),
                  debugShowCheckedModeBanner: false,
                  navigatorObservers: [AppPages.observer],
                  initialRoute: AppRoutes.Splash,
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  onGenerateRoute: AppPages.GenerateRouteSettings,
                )));
  }
}
