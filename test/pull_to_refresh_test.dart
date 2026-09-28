import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/pages.dart';
import 'package:app/common/services/storage.dart';
import 'package:app/common/utils/http.dart';
import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/global.dart';
import 'package:app/pages/home/view.dart';
import 'package:app/pages/home/bloc.dart' as home;
import 'package:app/pages/sale_point/view.dart';
import 'package:app/pages/sale_point/bloc.dart' as points;
import 'package:app/pages/sale_point_detail/view.dart';
import 'package:app/pages/sale_point_detail/widget.dart';
import 'package:app/pages/account_statement/view.dart';
import 'package:app/pages/account_statement/bloc.dart' as statement;
import 'package:app/pages/shipping_operation/view.dart';
import 'package:app/pages/shipping_operation/bloc.dart' as shipping;
import 'package:app/pages/shipping_operation/logic.dart' as shipping;
import 'package:app/pages/message/view.dart';
import 'package:app/pages/my_report/view.dart';
import 'package:app/pages/my_report/bloc.dart' as report;
import 'package:app/pages/shipment/view.dart';
import 'package:app/pages/revenue/view.dart';
import 'package:app/pages/collection_sale_point/view.dart';
import 'package:app/pages/collection_what/view.dart';
import 'package:app/pages/collection_what/bloc.dart' as collected;
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/common/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio originalDio;
  final calls = <String, List<RequestOptions>>{};
  final handlers =
      <String, Future<Map<String, dynamic>> Function(RequestOptions)>{};
  var revision = 1;

  setUpAll(() async {
    // Use the SDK's real Material font rather than Ahem's artificially wide
    // glyphs when exercising full pages with long labels.
    final configFile = File('.dart_tool/package_config.json');
    final config =
        jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
    final flutterPackage =
        (config['packages'] as List).singleWhere((p) => p['name'] == 'flutter');
    final flutterRoot =
        configFile.absolute.uri.resolve("${flutterPackage['rootUri']}/");
    final font = File.fromUri(flutterRoot.resolve(
        '../../bin/cache/artifacts/material_fonts/Roboto-Regular.ttf'));
    await (FontLoader('Roboto')
          ..addFont(Future.value(ByteData.sublistView(font.readAsBytesSync()))))
        .load();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    Global.storageService =
        await StorageService(secureStorage: _MemorySecureStorage()).init();
    originalDio = HttpUtil().dio;
    HttpUtil().dio = Dio()
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        final endpoint = options.path.split('/').last;
        calls.putIfAbsent(endpoint, () => []).add(options);
        dynamic data;
        switch (endpoint) {
          case 'get_profile':
            data = {
              'first_name': 'Agent',
              'balance': '$revision',
              'indebtedness': '0',
              'max_indebtedness': '100'
            };
          case 'sale_point_list':
          case 'sale_point_picker_list':
            data = [
              {
                'id': 1,
                'business_name': 'Store $revision',
                'first_name': 'Owner',
                'phone': '0922222222',
                'balance': '$revision',
                'indebtedness': '0',
                'status': 1,
                'last_recharge_amount': '$revision'
              }
            ];
          case 'agent_child_list':
            data = [
              {
                'id': 2,
                'first_name': 'Agent',
                'phone': '0911111111',
                'balance': '0',
                'indebtedness': '0'
              }
            ];
          case 'transfer_collection_total_record':
            data = '$revision';
          case 'account_statement':
            data = {
              'current_balance': '$revision',
              'money_owed_you': '$revision'
            };
          case 'pending_transactions_list':
          case 'shipping_operation':
          case 'notification':
          case 'sale_point_recharge_record_list':
          case 'sale_point_collect_record_list':
          case 'super_recharge_record_list':
          case 'super_collect_record_list':
          case 'transfer_collection_list':
            data = [];
          default:
            throw StateError('Unexpected request: ${options.path}');
        }
        final response = handlers[endpoint] == null
            ? <String, dynamic>{'code': 0, 'data': data, 'total_amount': '0'}
            : await handlers[endpoint]!(options);
        handler.resolve(
            Response(requestOptions: options, statusCode: 200, data: response));
      }));
  });
  setUp(() {
    calls.clear();
    handlers.clear();
    revision = 1;
  });
  tearDownAll(() {
    HttpUtil().dio.close();
    HttpUtil().dio = originalDio;
  });

  final pages = <String, (Widget Function(), List<String>)>{
    'home': (
      () => const HomePage(),
      ['get_profile', 'shipping_operation', 'pending_transactions_list']
    ),
    'sale points': (
      () => const SalePointPage(),
      ['sale_point_list', 'agent_child_list']
    ),
    'sale-point detail': (
      () => const SalePointDetailPage(),
      ['sale_point_list']
    ),
    'account statement': (
      () => const AccountStatementPage(),
      ['account_statement']
    ),
    'shipping operations': (
      () => const ShippingOperationPage(),
      ['shipping_operation']
    ),
    'notifications': (() => MessagePage(), ['notification']),
    'my report': (() => const MyReportPage(), ['super_recharge_record_list']),
    'recharge report': (
      () => const ShipmentPage(),
      ['sale_point_recharge_record_list']
    ),
    'collection report': (
      () => const RevenuePage(),
      ['sale_point_collect_record_list']
    ),
    'amount collected': (
      () => const CollectionWhatPage(),
      ['transfer_collection_total_record', 'transfer_collection_list']
    ),
    'sale-point collections': (
      () => const CollectionSalePointPage(),
      ['transfer_collection_list']
    ),
  };
  for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
    for (final entry in pages.entries) {
      testWidgets(
          '${entry.key} reloads on a downward swipe on ${platform.name} even with short or empty results',
          (tester) async {
        await _pump(tester, entry.value.$1(),
            platform: platform,
            arguments: entry.key == 'sale-point detail'
                ? SalePointData(id: 1, businessName: 'Old store', balance: '0')
                : null);
        calls.clear();
        revision = 2;
        await _pull(tester);
        for (final endpoint in entry.value.$2) {
          expect(calls[endpoint], hasLength(1), reason: endpoint);
          final params = calls[endpoint]!.single.data;
          if (params is Map && params.containsKey('page'))
            expect(params['page'], 0);
        }
        if (entry.key == 'sale-point detail') {
          final card =
              tester.widget<SalePointInfoCard>(find.byType(SalePointInfoCard));
          expect(card.item.businessName, 'Store 2');
          expect(card.item.balance, '2');
          expect(card.item.lastRechargeAmount, '2');
        }
        if (entry.key == 'home') {
          final context = tester.element(find.byType(HomePage));
          expect(context.read<home.HomeBloc>().state.userProfile?.balance, '2');
        }
        if (entry.key == 'account statement') {
          final context = tester.element(find.byType(AccountStatementPage));
          expect(
              context
                  .read<statement.AccountStatementBloc>()
                  .state
                  .accountStatement
                  ?.currentBalance,
              '2');
        }
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
      });
    }
  }

  testWidgets(
      'Amount Collected refresh keeps dates and updates total and records together',
      (tester) async {
    await _pump(tester, const CollectionWhatPage());
    final bloc = tester
        .element(find.byType(CollectionWhatPage))
        .read<collected.CollectionWhatBloc>();
    bloc.add(collected.StartDateChanged('2026-09-01 00:00:00'));
    bloc.add(collected.EndDateChanged('2026-09-15 23:59:59'));
    bloc.add(collected.AmountChanged('70'));
    bloc.add(collected.AgentCollectRecordListChanged([
      AgentCollectRecordData(
          id: 7, amount: '70', createdAt: '2026-09-15T10:00:00Z'),
    ]));
    await tester.pumpAndSettle();
    handlers['transfer_collection_total_record'] =
        (_) async => {'code': 0, 'data': '99'};
    handlers['transfer_collection_list'] = (_) async => {
          'code': 0,
          'data': [
            {'id': 10, 'amount': '99', 'created_at': '2026-09-15T10:00:00Z'}
          ]
        };
    await _pull(tester);
    expect(calls['transfer_collection_total_record']!.last.data, {
      'start_date': '2026-09-01 00:00:00',
      'end_date': '2026-09-15 23:59:59',
    });
    expect(calls['transfer_collection_list']!.last.data, {
      'start_date': '2026-09-01 00:00:00',
      'end_date': '2026-09-15 23:59:59',
      'page': 0,
    });
    expect(bloc.state.amount, '99');
    expect(bloc.state.agentCollectRecordList.map((e) => e.id), [10]);
    handlers['transfer_collection_total_record'] =
        (_) async => {'code': 0, 'data': '123'};
    handlers['transfer_collection_list'] =
        (_) async => {'code': 1, 'msg': 'Unavailable'};
    await _pull(tester);
    expect(bloc.state.amount, '99');
    expect(bloc.state.agentCollectRecordList.map((e) => e.id), [10]);
    handlers['transfer_collection_total_record'] =
        (_) async => {'code': 0, 'data': '0'};
    handlers['transfer_collection_list'] = (_) async => {'code': 0, 'data': []};
    await _pull(tester);
    expect(bloc.state.amount, '0');
    expect(bloc.state.agentCollectRecordList, isEmpty);
    expect(bloc.state.startDate, '2026-09-01 00:00:00');
    expect(bloc.state.endDate, '2026-09-15 23:59:59');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('home refresh waits for every section to finish', (tester) async {
    await _pump(tester, const HomePage());
    final pending = Completer<Map<String, dynamic>>();
    handlers['pending_transactions_list'] = (_) => pending.future;
    var finished = false;
    final refresh = tester
        .widget<RefreshIndicator>(find.byType(RefreshIndicator))
        .onRefresh()
        .then((_) => finished = true);
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    pending.complete({'code': 0, 'data': []});
    await tester.pumpAndSettle();
    await refresh;
    expect(finished, isTrue);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
      'refresh preserves account statement dates and sale-point search and sort',
      (tester) async {
    await _pump(tester, const AccountStatementPage());
    final statementBloc = tester
        .element(find.byType(AccountStatementPage))
        .read<statement.AccountStatementBloc>();
    statementBloc.add(statement.StartDateChanged('2026-09-01 00:00:00'));
    statementBloc.add(statement.EndDateChanged('2026-09-15 23:59:59'));
    await tester.pumpAndSettle();
    await _pull(tester);
    expect(calls['account_statement']!.last.data, {
      'start_date': '2026-09-01 00:00:00',
      'end_date': '2026-09-15 23:59:59'
    });
    await tester.pumpWidget(const SizedBox());
    await _pump(tester, const SalePointPage());
    final bloc =
        tester.element(find.byType(SalePointPage)).read<points.SalePointBloc>();
    bloc.add(points.SalePointSearchChanged('Store'));
    bloc.add(points.ToggleSalePointSort(points.SortField.balance));
    await tester.pumpAndSettle();
    final ascending = bloc.state.salePointSortAsc;
    await _pull(tester);
    expect(bloc.state.salePointSearch, 'Store');
    expect(bloc.state.salePointSortField, points.SortField.balance);
    expect(bloc.state.salePointSortAsc, ascending);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('My Report refresh uses the selected collection report',
      (tester) async {
    await _pump(tester, const MyReportPage());
    final bloc =
        tester.element(find.byType(MyReportPage)).read<report.MyReportBloc>();
    bloc.add(report.AgentChanged('revenue report'));
    await tester.pumpAndSettle();
    calls.clear();
    await _pull(tester);
    expect(calls['super_collect_record_list'], hasLength(1));
    expect(calls['super_recharge_record_list'], isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
      'refresh is disabled while editing a sale point so drafts stay intact',
      (tester) async {
    await _pump(tester, const SalePointDetailPage(),
        arguments:
            SalePointData(id: 1, businessName: 'Draft store', balance: '0'));
    await tester.ensureVisible(find.byIcon(Icons.edit));
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    expect(tester.widget<FormScrollView>(find.byType(FormScrollView)).onRefresh,
        isNull);
    expect(find.byType(RefreshIndicator), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
      'refresh replaces pages, preserves filters, ignores stale responses and retains data on failure',
      (tester) async {
    await _pump(tester, const ShippingOperationPage());
    final context = tester.element(find.byType(ShippingOperationPage));
    final bloc = context.read<shipping.ShippingOperationBloc>();
    bloc.add(shipping.DayChanged('2026-09-15'));
    bloc.add(shipping.ShippingOperationChanged([
      ShippingOperationData(amount: 'old', createdAt: '2026-09-15T10:00:00Z')
    ]));
    await tester.pumpAndSettle();
    final delayed = Completer<Map<String, dynamic>>();
    handlers['shipping_operation'] = (options) => options.data['page'] == 1
        ? delayed.future
        : Future.value({
            'code': 0,
            'data': [
              {'amount': '99', 'created_at': '2026-09-15T10:00:00Z'}
            ]
          });
    final oldPage = shipping.Logic(context: context)
        .shippingOperation('2026-09-15', 1, refresh: true);
    await tester.pump();
    await _pull(tester);
    expect(calls['shipping_operation']!.last.data,
        {'title': '2026-09-15', 'page': 0});
    expect(bloc.state.shippingOperationList.map((e) => e.amount), ['99']);
    delayed.complete({
      'code': 0,
      'data': [
        {'amount': 'stale', 'created_at': '2026-09-15T10:00:00Z'}
      ]
    });
    await tester.pumpAndSettle();
    await oldPage;
    expect(bloc.state.shippingOperationList.map((e) => e.amount), ['99']);
    handlers['shipping_operation'] =
        (_) async => {'code': 1, 'msg': 'Unavailable'};
    await _pull(tester);
    expect(bloc.state.shippingOperationList.map((e) => e.amount), ['99']);
    handlers['shipping_operation'] = (_) async => {'code': 0, 'data': []};
    await _pull(tester);
    expect(bloc.state.shippingOperationList, isEmpty);
    expect(bloc.state.day, '2026-09-15');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });
}

Future<void> _pull(WidgetTester tester) async {
  final scroll = find.byType(FormScrollView);
  tester
      .state<ScrollableState>(
          find.descendant(of: scroll, matching: find.byType(Scrollable)).first)
      .position
      .jumpTo(0);
  await tester.pumpAndSettle();
  await tester.dragFrom(
      tester.getTopLeft(scroll) + const Offset(10, 110), const Offset(0, 400),
      touchSlopY: 0);
  await tester.pumpAndSettle();
}

Future<void> _pump(WidgetTester tester, Widget page,
    {Object? arguments,
    TargetPlatform platform = TargetPlatform.android}) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    assetLoader: const _TranslationLoader(),
    startLocale: const Locale('en'),
    saveLocale: false,
    child: Builder(
        builder: (context) => MultiBlocProvider(
              providers: [...AppPages.Blocer(context)],
              child: ScreenUtilInit(
                  designSize: const Size(375, 812),
                  builder: (context, _) => MaterialApp(
                        theme: AppTheme.light.copyWith(platform: platform),
                        locale: context.locale,
                        supportedLocales: context.supportedLocales,
                        localizationsDelegates: context.localizationDelegates,
                        builder: EasyLoading.init(),
                        onGenerateRoute: (settings) => MaterialPageRoute<void>(
                            settings: RouteSettings(
                                name: settings.name, arguments: arguments),
                            builder: (_) => Scaffold(body: page)),
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
