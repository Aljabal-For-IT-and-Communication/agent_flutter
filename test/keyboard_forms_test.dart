import 'dart:convert';
import 'dart:io';

import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/pages.dart';
import 'package:app/common/services/storage.dart';
import 'package:app/common/utils/http.dart';
import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/global.dart';
import 'package:app/pages/account/view.dart';
import 'package:app/pages/collection_item/view.dart';
import 'package:app/pages/collection_item/widget.dart' as collect;
import 'package:app/pages/credit/view.dart';
import 'package:app/pages/debit/view.dart';
import 'package:app/pages/frame/change_password/view.dart';
import 'package:app/pages/frame/register/view.dart';
import 'package:app/pages/frame/sign_in/view.dart';
import 'package:app/pages/revenue/view.dart';
import 'package:app/pages/shipment/view.dart';
import 'package:app/pages/sale_point_detail/view.dart';
import 'package:app/pages/transfer_balance/bloc.dart' as transfer;
import 'package:app/pages/transfer_balance/view.dart';
import 'package:app/pages/transfer_balance/widget.dart' as transfer;
import 'package:app/pages/transformation/view.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio originalDio;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    Global.storageService =
        await StorageService(secureStorage: _MemorySecureStorage()).init();
    originalDio = HttpUtil().dio;
    HttpUtil().dio = Dio()
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // No test may reach the real server or submit a transaction.
        dynamic data = <dynamic>[];
        if (options.path.endsWith('agent_child_list')) {
          data = [
            {
              'id': 1,
              'first_name': 'Agent',
              'last_name': 'One',
              'phone': '0911111111'
            }
          ];
        } else if (options.path.endsWith('sale_point_picker_list')) {
          data = [
            {
              'id': 1,
              'business_name': 'Store One',
              'phone': '0922222222',
              'balance': '0'
            }
          ];
        } else if (options.path.endsWith('types_list')) {
          data = [
            {'id': 1, 'type_name': 'Cash', 'needs_validation': false}
          ];
        } else if (options.path.endsWith('get_balance_summary')) {
          data = {'balance': '0', 'indebtedness': '0'};
        } else {
          throw StateError('Unexpected request: ${options.path}');
        }
        handler.resolve(Response(
            requestOptions: options,
            statusCode: 200,
            data: {'code': 0, 'data': data}));
      }));
  });

  tearDownAll(() {
    HttpUtil().dio.close();
    HttpUtil().dio = originalDio;
  });

  final pages = <String, Widget Function()>{
    'transfer': () => const TransferBalancePage(),
    'collections': () => const CollectionItemPage(),
    'debit': () => const DebitPage(),
    'shipment': () => const ShipmentPage(),
    'revenue': () => const RevenuePage(),
    'credit': () => const CreditPage(),
    'login': () => const SignInPage(),
    'change password': () => ChangePasswordPage(),
    'legacy transfer': () => const TransformationPage(),
    'register': () => const RegisterPage(),
    'profile': () => const AccountPage(),
    'sale point editing': () => const SalePointDetailPage(),
  };
  for (final entry in pages.entries) {
    for (final language in ['en', 'ar']) {
      testWidgets(
          '${entry.key} keeps its final field reachable with the $language keyboard open',
          (tester) async {
        _setScreen(tester);
        final page = entry.value();
        await _pump(tester, page,
            language: language,
            arguments: entry.key == 'sale point editing'
                ? SalePointData(id: 1, businessName: 'Test store', balance: '0')
                : null);
        if (entry.key == 'sale point editing') {
          await tester.ensureVisible(find.byIcon(Icons.edit));
          await tester.tap(find.byIcon(Icons.edit));
          await tester.pumpAndSettle();
        }
        final scroll = find.byType(FormScrollView).first;
        final inputs =
            find.descendant(of: scroll, matching: find.byType(TextField));
        expect(inputs, findsWidgets);
        final field = inputs.last;
        await tester.ensureVisible(field);
        await tester.showKeyboard(field);
        tester.view.viewInsets = const FakeViewPadding(bottom: 300);
        await tester.pumpAndSettle();
        await tester.ensureVisible(field);
        await tester.pumpAndSettle();
        expect(tester.getRect(scroll).bottom, lessThanOrEqualTo(400));
        expect(tester.getRect(field).bottom, lessThanOrEqualTo(400));
        expect(tester.getRect(field).top, greaterThanOrEqualTo(-0.001));
        expect(tester.testTextInput.isVisible, isTrue);
        if (entry.key == 'transfer' || entry.key == 'collections') {
          final button = entry.key == 'transfer'
              ? find.byType(transfer.BuildBtn)
              : find.text('collection'.tr()).last;
          await tester.ensureVisible(button);
          await tester.pumpAndSettle();
          expect(tester.getRect(button).bottom, lessThanOrEqualTo(400));
          expect(button.hitTestable(), findsOneWidget);
          expect(tester.testTextInput.isVisible, isTrue);
        }
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets(
      'collection type below amount is reachable and dismisses the keyboard when opened',
      (tester) async {
    _setScreen(tester);
    await _pump(tester, const CollectionItemPage());
    final amount = find.descendant(
        of: find.byType(collect.BuildAmountInput),
        matching: find.byType(TextField));
    await tester.ensureVisible(amount);
    await tester.showKeyboard(amount);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    final dropdown = find.byType(DropdownButton<int>);
    await tester.ensureVisible(dropdown);
    await tester.pumpAndSettle();
    expect(tester.getRect(dropdown).bottom, lessThanOrEqualTo(400));
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    expect(tester.testTextInput.isVisible, isFalse);
    expect(find.text('Cash').hitTestable(), findsWidgets);
    await tester.tap(find.text('Cash').hitTestable().last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'recipient suggestions flip above keyboard and selection dismisses it',
      (tester) async {
    _setScreen(tester);
    final bloc = transfer.TransferBalanceBloc();
    addTearDown(bloc.close);
    bloc.add(transfer.AgentListChanged([
      AgentData(
          id: 1,
          firstName: 'Selectable',
          lastName: 'Agent',
          phone: '0911111111')
    ]));
    await _pump(
        tester,
        BlocProvider.value(
          value: bloc,
          child: Scaffold(
              body: FormScrollView(slivers: const [
            SliverToBoxAdapter(child: SizedBox(height: 310)),
            SliverToBoxAdapter(child: transfer.BuildDropdownAgentNameInput()),
          ])),
        ));
    final field = find.byType(TextField);
    await tester.showKeyboard(field);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    // Put the field near the keyboard again, leaving room only above it.
    final position =
        tester.state<ScrollableState>(find.byType(Scrollable).first).position;
    position.jumpTo(0);
    await tester.pumpAndSettle();
    final suggestion = find.text('Selectable Agent');
    expect(suggestion.hitTestable(), findsOneWidget);
    expect(
        tester.getRect(suggestion).bottom, lessThan(tester.getRect(field).top));
    await tester.tap(suggestion);
    await tester.pumpAndSettle();
    expect(bloc.state.agentItem?.id, 1);
    expect(tester.testTextInput.isVisible, isFalse);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('password Next skips visibility buttons and moves between fields',
      (tester) async {
    _setScreen(tester);
    await _pump(tester, ChangePasswordPage());
    final fields = find.byType(TextField);
    await tester.showKeyboard(fields.first);
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<EditableText>(find.byType(EditableText).at(1))
            .focusNode
            .hasFocus,
        isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<EditableText>(find.byType(EditableText).at(2))
            .focusNode
            .hasFocus,
        isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(tester.testTextInput.isVisible, isFalse);
  });

  testWidgets('dragging a form dismisses the keyboard', (tester) async {
    _setScreen(tester);
    await _pump(tester, ChangePasswordPage());
    await tester.showKeyboard(find.byType(TextField).first);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(FormScrollView), const Offset(0, -100));
    await tester.pumpAndSettle();
    expect(tester.testTextInput.isVisible, isFalse);
  });
}

void _setScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(320, 700);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetViewInsets);
}

Future<void> _pump(WidgetTester tester, Widget page,
    {String language = 'en', Object? arguments}) async {
  await tester.pumpWidget(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    assetLoader: const _TranslationLoader(),
    startLocale: Locale(language),
    saveLocale: false,
    child: Builder(
        builder: (context) => MultiBlocProvider(
              providers: [...AppPages.Blocer(context)],
              child: ScreenUtilInit(
                  designSize: const Size(375, 812),
                  builder: (context, _) => MaterialApp(
                        locale: context.locale,
                        supportedLocales: context.supportedLocales,
                        localizationsDelegates: context.localizationDelegates,
                        onGenerateRoute: (settings) => MaterialPageRoute<void>(
                          settings: RouteSettings(
                              name: settings.name, arguments: arguments),
                          builder: (_) => page,
                        ),
                      )),
            )),
  ));
  await tester.pumpAndSettle();
}

class _TranslationLoader extends AssetLoader {
  const _TranslationLoader();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync())
          as Map<String, dynamic>;
}

class _MemorySecureStorage implements SecureStorageAdapter {
  @override
  Future<String?> read(String key) async => null;
  @override
  Future<void> write(String key, String value) async {}
  @override
  Future<void> delete(String key) async {}
}
