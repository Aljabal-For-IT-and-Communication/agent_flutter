import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/common/services/storage.dart';
import 'package:app/common/style/theme.dart';
import 'package:app/common/utils/http.dart';
import 'package:app/common/utils/recipient_report.dart';
import 'package:app/common/utils/recipient_report_pdf.dart';
import 'package:app/common/widgets/recipient_report_controls.dart';
import 'package:app/global.dart';
import 'package:app/pages/shipment/bloc.dart' as shipment;
import 'package:app/pages/shipment/logic.dart' as shipment;
import 'package:app/pages/shipment/view.dart';
import 'package:app/pages/revenue/bloc.dart' as revenue;
import 'package:app/pages/revenue/logic.dart' as revenue;
import 'package:app/pages/revenue/view.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:printing/printing.dart';
import 'package:printing/src/interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter_keyboard_visibility'), (_) async => null);
  late Dio originalDio;
  late PrintingPlatform originalPrinting;
  late _Printer printer;
  final calls = <Map<String, dynamic>>[];
  late Future<Map<String, dynamic>> Function(Map<String, dynamic>) respond;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
    Global.storageService =
        await StorageService(secureStorage: _MemorySecureStorage()).init();
    originalDio = HttpUtil().dio;
    originalPrinting = PrintingPlatform.instance;
    final configFile = File('.dart_tool/package_config.json');
    final config =
        jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
    final flutter =
        (config['packages'] as List).singleWhere((p) => p['name'] == 'flutter');
    final root = configFile.absolute.uri.resolve('${flutter['rootUri']}/');
    final font = File.fromUri(root.resolve(
        '../../bin/cache/artifacts/material_fonts/Roboto-Regular.ttf'));
    await (FontLoader('Roboto')
          ..addFont(Future.value(ByteData.sublistView(font.readAsBytesSync()))))
        .load();
  });
  setUp(() {
    calls.clear();
    printer = _Printer();
    PrintingPlatform.instance = printer;
    respond = (request) async {
      final offset = request['page'] as int;
      return {
        'code': 0,
        'total_amount': '1.25',
        'data': [
          for (var i = offset == -1 ? 0 : offset;
              i < (offset == -1 ? 10 : (offset + 8).clamp(0, 10));
              i++)
            {
              'id': i + 1,
              'amount': '0.125',
              'created_at': '2026-09-01T10:30:00+02:00',
              'first_name': 'Agent One',
              'business_name': 'Shop One',
              'phone': '0911111111',
              'collect_type_name': 'Cash',
              'recharge_type_name': 'Regular'
            }
        ]
      };
    };
    HttpUtil().dio = Dio()
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        Map<String, dynamic> result;
        if (options.path.endsWith('agent_child_list')) {
          result = {
            'code': 0,
            'data': [
              {
                'id': 7,
                'first_name': 'Agent',
                'last_name': 'One',
                'phone': '0911111111'
              }
            ]
          };
        } else if (options.path.endsWith('sale_point_picker_list')) {
          result = {
            'code': 0,
            'data': [
              {'id': 9, 'business_name': 'Shop One', 'phone': '0922222222'}
            ]
          };
        } else {
          final request = Map<String, dynamic>.from(options.data as Map);
          calls.add(request);
          result = await respond(request);
        }
        handler.resolve(
            Response(requestOptions: options, statusCode: 200, data: result));
      }));
  });
  tearDown(() {
    HttpUtil().dio.close();
  });
  tearDownAll(() {
    HttpUtil().dio = originalDio;
    PrintingPlatform.instance = originalPrinting;
  });

  test('decimal totals preserve precision and sign', () {
    expect(sumReportAmounts(['0.1', '0.2', '-0.125']), '0.175');
    expect(sumReportAmounts(['999999999999.999', '0.001']), '1000000000000');
    expect(sumReportAmounts(['-1', '0.999']), '-0.001');
    expect(sumReportAmounts([]), '0');
    expect(() => sumReportAmounts(['bad']), throwsFormatException);
  });
  test('optional filters validate and serialize exact date times', () {
    RecipientReportFilter filter(String start, String end, {int? id = 7}) =>
        RecipientReportFilter(
            category: 'Agent',
            id: id,
            name: 'One',
            phone: '091',
            startDate: start,
            endDate: end);
    expect(filter('', '').validationError, isNull);
    expect(filter('', '', id: null).validationError, isNotNull);
    expect(filter('2026-09-01 10:00:00', '').validationError, isNotNull);
    expect(filter('', '2026-09-01 10:00:00').validationError, isNotNull);
    expect(filter('2026-09-01 10:00:00', '2026-09-01 10:00:00').validationError,
        isNotNull);
    expect(filter('2026-09-02 10:00:00', '2026-09-01 10:00:00').validationError,
        isNotNull);
    expect(filter('2026-02-30 10:00:00', '2026-09-01 10:00:00').validationError,
        isNotNull);
    final valid = filter('2026-09-01 10:00:00', '2026-09-02 10:00:00');
    expect(valid.validationError, isNull);
    expect(valid.request(-1).toJson(), {
      'category': 'Agent',
      'id': 7,
      'page': -1,
      'start_date': '2026-09-01 10:00:00',
      'end_date': '2026-09-02 10:00:00'
    });
  });

  for (final kind in ['shipment', 'revenue']) {
    testWidgets(
        '$kind search, total, pagination, refresh, dates and recipient changes',
        (tester) async {
      final h = await _pump(tester, kind);
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(h.rows.length, 8);
      expect(h.total, '1.25');
      expect(calls.last['page'], 0);
      await tester.runAsync(h.more);
      await tester.pumpAndSettle();
      expect(h.rows.length, 10);
      expect(calls.last['page'], 8);
      expect(h.total, '1.25');
      await tester.runAsync(h.more);
      expect(calls.length, 2); // exhausted
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(h.rows.length, 8);
      h.dates('2026-09-01 10:00:00', '2026-09-01 11:00:00');
      await tester.pumpAndSettle();
      expect(h.rows, isEmpty);
      expect(h.total, '');
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(calls.last['start_date'], '2026-09-01 10:00:00');
      h.pos();
      await tester.pumpAndSettle();
      expect(h.rows, isEmpty);
      expect(h.total, '');
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(calls.last['category'], 'SalePoint');
      expect(calls.last['id'], 9);
      await tester.runAsync(h.refresh);
      await tester.pumpAndSettle();
      expect(calls.last['end_date'], '2026-09-01 11:00:00');
      expect(calls.last['page'], 0);
      final clear = find.text('Clear dates');
      await tester.ensureVisible(clear);
      await tester.tap(clear);
      await tester.pumpAndSettle();
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(calls.last['start_date'], '');
      expect(calls.last['end_date'], '');
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
    testWidgets('$kind ignores stale responses and keeps results on failure',
        (tester) async {
      final h = await _pump(tester, kind);
      final pending = Completer<Map<String, dynamic>>();
      respond = (_) => pending.future;
      final search = h.search();
      await tester.pump();
      h.dates('2026-09-01 10:00:00', '2026-09-01 11:00:00');
      await tester.pump();
      pending.complete({
        'code': 0,
        'total_amount': '99',
        'data': [
          {'id': 99, 'amount': '99'}
        ]
      });
      await tester.pumpAndSettle();
      await search;
      expect(h.rows, isEmpty);
      expect(h.total, '');
      respond = (_) async => {
            'code': 0,
            'total_amount': '5',
            'data': [
              {'id': 1, 'amount': '5'}
            ]
          };
      await tester.runAsync(h.search);
      await tester.pumpAndSettle();
      expect(h.total, '5');
      respond = (_) async => {'code': 1, 'msg': 'Failed'};
      await tester.runAsync(h.refresh);
      await tester.pumpAndSettle();
      expect(h.rows.length, 1);
      expect(h.total, '5');
      respond = (_) async => {'code': 0, 'total_amount': '0', 'data': []};
      await tester.runAsync(h.refresh);
      await tester.pumpAndSettle();
      expect(h.rows, isEmpty);
      expect(h.total, '0');
      await tester.pumpWidget(const SizedBox());
    });
    testWidgets('$kind prints Agent reports and discards outdated exports',
        (tester) async {
      final h = await _pump(tester, kind);
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(calls.last['category'], 'Agent');
      expect(calls.last['id'], 7);
      expect(printer.count, 1);
      final pending = Completer<Map<String, dynamic>>();
      respond = (_) => pending.future;
      final exporting = h.print();
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 20));
      }
      h.pos();
      await tester.pump();
      pending.complete({'code': 0, 'total_amount': '0', 'data': []});
      await tester.pumpAndSettle();
      await exporting;
      expect(printer.count, 1);
      if (kind == 'shipment') {
        h.bloc.add(const shipment.SalePointItemChanged(null));
      } else {
        h.bloc.add(const revenue.SalePointItemChanged(null));
      }
      await tester.pumpAndSettle();
      final before = calls.length;
      await tester.runAsync(h.search);
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(calls.length, before);
      expect(printer.count, 1);
      await tester.pumpWidget(const SizedBox());
    });
    testWidgets(
        '$kind exports all rows once, validates filters and handles failures',
        (tester) async {
      final h = await _pump(tester, kind);
      h.dates('2026-09-01 10:00:00', '');
      await tester.pumpAndSettle();
      await tester.runAsync(h.print);
      expect(calls, isEmpty);
      expect(printer.count, 0);
      h.dates('', '');
      h.pos();
      await tester.pumpAndSettle();
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(calls.last['page'], -1);
      expect(calls.last['category'], 'SalePoint');
      expect(printer.count, 1);
      expect(printer.lastBytes, greaterThan(1000));
      expect(h.rows, isEmpty); // export does not replace list
      final pending = Completer<Map<String, dynamic>>();
      respond = (_) => pending.future;
      final before = calls.length;
      final first = h.print();
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 20));
      }
      await tester.runAsync(h.print);
      expect(calls.length, before + 1);
      pending.complete({'code': 1, 'msg': 'Failed'});
      await tester.pumpAndSettle();
      await first;
      expect(printer.count, 1);
      respond = (_) async => {
            'code': 0,
            'total_amount': '100',
            'data': [
              {'id': 1, 'amount': '1'}
            ]
          };
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(printer.count, 1); // inconsistent total
      respond = (_) async => {'code': 0, 'data': []};
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(printer.count, 1); // old server cannot export silently
      respond = (_) async => {'code': 0, 'total_amount': '0', 'data': []};
      await tester.runAsync(h.print);
      await tester.pumpAndSettle();
      expect(printer.count, 2);
      await tester.pumpWidget(const SizedBox());
    });
  }

  for (final language in ['en', 'ar']) {
    test('multipage $language PDF uses the real builder and bundled assets',
        () async {
      final labels = jsonDecode(
              File('assets/translations/$language.json').readAsStringSync())
          as Map<String, dynamic>;
      for (final kind in ['shipment', 'revenue']) {
        final bytes = await buildRecipientReportPdf(
            title: labels[kind == 'shipment'
                ? 'Shipments report'
                : 'Revenue Report'] as String,
            filter: RecipientReportFilter(
                category: 'SalePoint',
                id: 7,
                name: language == 'ar'
                    ? 'نقطة بيع ذات اسم طويل لاختبار عرض النص في تقرير الشحنات والإيرادات'
                    : 'A very long sales point business name for checking report wrapping and pagination',
                phone: '0921234567',
                startDate: '2026-09-01 00:00:00',
                endDate: '2026-09-28 23:00:00'),
            rows: [
              for (var i = 0; i < 85; i++)
                RecipientReportRow(
                    amount: '0.125',
                    createdAt: '2026-09-01T08:30:00Z',
                    collectType: language == 'ar' ? 'نقدي' : 'Cash',
                    rechargeType:
                        language == 'ar' ? 'شحن عادي' : 'Regular recharge')
            ],
            isArabic: language == 'ar',
            translate: (key) => labels[key] as String? ?? key);
        expect(bytes.sublist(0, 4), [37, 80, 68, 70]);
        // Optional QA artifacts are generated by the actual app code.
        if (const bool.fromEnvironment('REPORT_PDF_QA')) {
          Directory('tmp/pdfs').createSync(recursive: true);
          File('tmp/pdfs/$kind-$language.pdf').writeAsBytesSync(bytes);
        }
      }
    });
  }
}

class _Harness {
  _Harness(this.context, this.kind);
  final BuildContext context;
  final String kind;
  dynamic get bloc => kind == 'shipment'
      ? context.read<shipment.ShipmentBloc>()
      : context.read<revenue.RevenueBloc>();
  List<dynamic> get rows => kind == 'shipment'
      ? bloc.state.agentRechargeRecordList
      : bloc.state.agentCollectRecordList;
  String get total => bloc.state.totalAmount as String;
  Future<void> search() => kind == 'shipment'
      ? shipment.Logic(context: context).postTransformation(refresh: true)
      : revenue.Logic(context: context).postTransformation(refresh: true);
  Future<void> refresh() => kind == 'shipment'
      ? shipment.Logic(context: context)
          .postTransformation(refresh: true, showLoading: false)
      : revenue.Logic(context: context)
          .postTransformation(refresh: true, showLoading: false);
  Future<void> more() => kind == 'shipment'
      ? shipment.Logic(context: context).postTransformation()
      : revenue.Logic(context: context).postTransformation();
  Future<void> print() => kind == 'shipment'
      ? shipment.Logic(context: context).printReport()
      : revenue.Logic(context: context).printReport();
  void dates(String start, String end) {
    if (kind == 'shipment') {
      bloc.add(shipment.ReportDatesChanged(start, end));
    } else {
      bloc.add(revenue.ReportDatesChanged(start, end));
    }
  }

  void pos() {
    if (kind == 'shipment') {
      bloc.add(const shipment.AgentChanged('SalePoint'));
    } else {
      bloc.add(const revenue.AgentChanged('SalePoint'));
    }
  }
}

Future<_Harness> _pump(WidgetTester tester, String kind) async {
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
                  providers: [
                    BlocProvider(create: (_) => shipment.ShipmentBloc()),
                    BlocProvider(create: (_) => revenue.RevenueBloc())
                  ],
                  child: ScreenUtilInit(
                      designSize: const Size(375, 812),
                      builder: (context, _) => MaterialApp(
                          theme: AppTheme.light,
                          locale: context.locale,
                          supportedLocales: context.supportedLocales,
                          localizationsDelegates: context.localizationDelegates,
                          home: kind == 'shipment'
                              ? const ShipmentPage()
                              : const RevenuePage()))))));
  await tester.pumpAndSettle();
  return _Harness(tester.element(find.byType(RecipientReportControls)), kind);
}

class _Printer extends PrintingPlatform {
  int count = 0, lastBytes = 0;
  @override
  Future<bool> layoutPdf(
      Printer? printer,
      LayoutCallback onLayout,
      String name,
      PdfPageFormat format,
      bool dynamicLayout,
      bool usePrinterSettings,
      OutputType outputType,
      bool forceCustomPrintPaper) async {
    count++;
    lastBytes = (await onLayout(format)).length;
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
