import 'dart:convert';
import 'dart:io';

import 'package:app/common/entities/sale_point.dart';
import 'package:app/common/utils/date.dart';
import 'package:app/pages/sale_point_detail/widget.dart';
import 'package:app/pages/sale_point/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test(
      'latest activity accepts decimal strings, numeric zero and missing history',
      () {
    final item = SalePointData.fromJson({
      'last_recharge_amount': '12.345',
      'last_recharge_at': '2026-09-12T09:00:00Z',
      'last_collect_amount': 0,
      'last_collect_at': '2026-09-13T09:00:00Z',
    });
    final restored = SalePointData.fromJson(item.toJson());
    expect(restored.lastRechargeAmount, '12.345');
    expect(restored.lastCollectAmount, '0');
    expect(restored.lastRechargeAt, '2026-09-12T09:00:00Z');
    expect(restored.lastCollectAt, '2026-09-13T09:00:00Z');
    final empty = SalePointData.fromJson({});
    expect(empty.lastCollectAmount, isNull);
    expect(empty.lastRechargeAmount, isNull);
    expect(empty.lastCollectAt, isNull);
    expect(empty.lastRechargeAt, isNull);
  });

  for (final language in ['en', 'ar']) {
    testWidgets(
        'latest amounts and dates fit a narrow $language sale-point card',
        (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final item = SalePointData(
        businessName: 'Store',
        lastRechargeAmount: '12.345',
        lastRechargeAt: '2026-09-12T09:00:00Z',
        lastCollectAmount: '0',
        lastCollectAt: '2026-09-13T09:00:00Z',
      );
      await _pumpCard(tester, item, language);
      final rechargeAmountLabel =
          language == 'ar' ? 'مبلغ آخر شحن' : 'Last recharge amount';
      final rechargeDateLabel =
          language == 'ar' ? 'تاريخ آخر شحن' : 'Last recharge date';
      final collectAmountLabel =
          language == 'ar' ? 'مبلغ آخر توريد' : 'Last collect amount';
      final collectDateLabel =
          language == 'ar' ? 'تاريخ آخر توريد' : 'Last collect date';
      expect(find.text('$rechargeAmountLabel: 12.345 LYD'), findsOneWidget);
      expect(find.text('$collectAmountLabel: 0 LYD'), findsOneWidget);
      expect(
          find.text('$rechargeDateLabel: ${timeFormated(item.lastRechargeAt)}'),
          findsOneWidget);
      expect(
          find.text('$collectDateLabel: ${timeFormated(item.lastCollectAt)}'),
          findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final language in ['en', 'ar']) {
    testWidgets(
        'detail card shows latest activity on a narrow $language screen',
        (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final item = SalePointData(
          businessName: 'Store',
          lastRechargeAmount: '12.345',
          lastRechargeAt: '2026-09-12T09:00:00Z',
          lastCollectAmount: '0',
          lastCollectAt: '2026-09-13T09:00:00Z');
      await _pumpCard(tester, item, language, detail: true);
      final labels = language == 'ar'
          ? [
              'مبلغ آخر شحن',
              'تاريخ آخر شحن',
              'مبلغ آخر توريد',
              'تاريخ آخر توريد'
            ]
          : [
              'Last recharge amount',
              'Last recharge date',
              'Last collect amount',
              'Last collect date'
            ];
      for (final label in labels) {
        expect(find.text(label), findsOneWidget);
      }
      expect(find.text('12.345 LYD'), findsOneWidget);
      final row = find
          .ancestor(of: find.text(labels[2]), matching: find.byType(Row))
          .first;
      expect(find.descendant(of: row, matching: find.text('0 LYD')),
          findsOneWidget);
      expect(find.text(timeFormated(item.lastRechargeAt)), findsOneWidget);
      expect(find.text(timeFormated(item.lastCollectAt)), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('detail activity handles missing history and malformed dates',
      (tester) async {
    await _pumpCard(tester, SalePointData(), 'en', detail: true);
    expect(find.text('—'), findsNWidgets(4));
    await _pumpCard(tester, SalePointData(lastRechargeAt: 'unknown'), 'en',
        detail: true);
    expect(find.text('unknown'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sale point without history displays four placeholders',
      (tester) async {
    await _pumpCard(tester, SalePointData(businessName: 'New store'), 'en');
    for (final label in [
      'Last recharge amount',
      'Last recharge date',
      'Last collect amount',
      'Last collect date'
    ]) {
      expect(find.text('$label: —'), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpCard(WidgetTester tester, SalePointData item, String language,
    {bool detail = false}) async {
  await tester.pumpWidget(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    assetLoader: const _LocalTranslationLoader(),
    fallbackLocale: const Locale('en'),
    startLocale: Locale(language),
    saveLocale: false,
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Scaffold(
            body: SingleChildScrollView(
                child: detail
                    ? SalePointInfoCard(item: item, balance: 0)
                    : BuildListItem(item: item))),
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

class _LocalTranslationLoader extends AssetLoader {
  const _LocalTranslationLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return jsonDecode(
            File('$path/${locale.languageCode}.json').readAsStringSync())
        as Map<String, dynamic>;
  }
}
