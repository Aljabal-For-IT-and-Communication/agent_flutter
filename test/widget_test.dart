import 'package:app/common/utils/http.dart';
import 'package:app/pages/frame/sign_in/bloc.dart';
import 'package:app/pages/frame/sign_in/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('forced update dialog blocks navigation without an exit action',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: const MaterialApp(
          home: ForceUpdateDialog(message: 'Install the latest version.'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Update Required'), findsOneWidget);
    expect(find.text('Install the latest version.'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(TextButton), findsNothing);

    final popScope = tester.widget<PopScope>(find.byType(PopScope));
    expect(popScope.canPop, isFalse);
  });

  testWidgets('login password is hidden until the eye button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => BlocProvider(
            create: (_) => SignInBloc(),
            child: const MaterialApp(
              home: Scaffold(body: BuildPasswordInput()),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    TextField passwordField = tester.widget(find.byType(TextField));
    expect(passwordField.obscureText, isTrue);
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

    await tester.tap(
      find.byKey(const Key('login_password_visibility_toggle')),
    );
    await tester.pump();

    passwordField = tester.widget(find.byType(TextField));
    expect(passwordField.obscureText, isFalse);
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });
}
