import 'package:app/common/widgets/form_scroll_view.dart';
import 'package:app/common/widgets/form_typeahead_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final count in [0, 1, 2, 30]) {
    testWidgets('$count suggestions reserve only their measured content height',
        (tester) async {
      await _pump(tester, count: count);
      final field = find.byType(TextField);
      await tester.showKeyboard(field);
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      await tester.pumpAndSettle();
      final popup = count == 0
          ? find.byType(SingleChildScrollView)
          : find.byType(ListView);
      final popupRect = tester.getRect(popup);
      // Deliberately use unequal row heights to catch fixed row/count estimates.
      final expectedHeight = switch (count) {
        1 => 48.0,
        2 => 120.0,
        30 => 240.0,
        _ => popupRect.height,
      };
      expect(popupRect.height, closeTo(expectedHeight, 0.5));
      if (count == 0) expect(popupRect.height, lessThan(60));
      expect(popupRect.top, greaterThanOrEqualTo(tester.getRect(field).bottom));
      expect(popupRect.bottom, lessThanOrEqualTo(400));
      final position = _position(tester);
      // The field starts at 310 and is 48 high; only the missing room is scrolled.
      final requiredScroll =
          (310 + 48 + expectedHeight + 8 - 400).clamp(0.0, 1000.0);
      expect(position.pixels, closeTo(requiredScroll, 1));
      expect(tester.testTextInput.isVisible, isTrue);
      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets('keyboard animation produces one uninterrupted form scroll',
      (tester) async {
    var scrollStarts = 0;
    await _pump(tester,
        count: 30, fieldTop: 600, onScrollStart: () => scrollStarts++);
    await tester.showKeyboard(find.byType(TextField));
    // Model the sequence of viewport changes emitted by an animating keyboard.
    for (var inset = 20.0; inset <= 300; inset += 20) {
      tester.view.viewInsets = FakeViewPadding(bottom: inset);
      await tester.pump(const Duration(milliseconds: 16));
      expect(scrollStarts, 0);
    }
    final offsets = <double>[];
    for (var frame = 0; frame < 30; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
      offsets.add(_position(tester).pixels);
    }
    await tester.pumpAndSettle();
    expect(scrollStarts, 1);
    for (var i = 1; i < offsets.length; i++) {
      expect(offsets[i], greaterThanOrEqualTo(offsets[i - 1]));
    }
    expect(
        offsets.where((offset) => offset > 0 && offset < offsets.last).length,
        greaterThan(3));
    expect(tester.getRect(find.byType(ListView)).height, 240);
    expect(
        tester.getRect(find.byType(ListView)).bottom, lessThanOrEqualTo(400));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
      'filtering to short and empty results releases extra space smoothly',
      (tester) async {
    await _pump(tester, count: 30, filter: true);
    final field = find.byType(TextField);
    await tester.showKeyboard(field);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    final before = _position(tester).pixels;
    await tester.enterText(field, 'one');
    await tester.pump(const Duration(milliseconds: 16));
    final offsets = <double>[_position(tester).pixels];
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 16));
      offsets.add(_position(tester).pixels);
    }
    await tester.pumpAndSettle();
    expect(tester.getRect(find.byType(ListView)).height, 48);
    expect(_position(tester).pixels, lessThan(before));
    for (var i = 1; i < offsets.length; i++) {
      expect((offsets[i] - offsets[i - 1]).abs(), lessThan(before / 2));
    }
    await tester.enterText(field, 'none');
    await tester.pumpAndSettle();
    expect(find.text('No items found!').hitTestable(), findsOneWidget);
    expect(tester.getRect(find.byType(SingleChildScrollView)).height,
        lessThan(60));
    expect(_position(tester).maxScrollExtent, lessThan(30));
    expect(tester.testTextInput.isVisible, isTrue);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('measuring a large dropdown keeps off-screen options lazy',
      (tester) async {
    var built = 0;
    await _pump(tester, count: 2000, onItemBuilt: () => built++);
    await tester.showKeyboard(find.byType(TextField));
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    expect(built, greaterThan(0));
    expect(built, lessThan(100));
    expect(tester.getRect(find.byType(ListView)).height, 240);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a dropdown with enough room does not move the form',
      (tester) async {
    var scrollStarts = 0;
    await _pump(tester,
        count: 2, fieldTop: 20, onScrollStart: () => scrollStarts++);
    await tester.showKeyboard(find.byType(TextField));
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    expect(_position(tester).pixels, 0);
    expect(scrollStarts, 0);
    await tester.pumpWidget(const SizedBox());
  });
}

ScrollPosition _position(WidgetTester tester) => tester
    .state<ScrollableState>(find
        .descendant(
            of: find.byType(FormScrollView), matching: find.byType(Scrollable))
        .first)
    .position;

Future<void> _pump(WidgetTester tester,
    {required int count,
    double fieldTop = 310,
    bool filter = false,
    VoidCallback? onScrollStart,
    VoidCallback? onItemBuilt}) async {
  tester.view.physicalSize = const Size(320, 700);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetViewInsets);
  await tester.pumpWidget(MaterialApp(
      home: Scaffold(
    body: NotificationListener<ScrollStartNotification>(
      onNotification: (notification) {
        if (notification.depth == 0) onScrollStart?.call();
        return false;
      },
      child: FormScrollView(slivers: [
        SliverToBoxAdapter(child: SizedBox(height: fieldTop)),
        SliverToBoxAdapter(
            child: SizedBox(
                height: 48,
                child: FormTypeAheadField<int>(
                  builder: (context, controller, focusNode) =>
                      TextField(controller: controller, focusNode: focusNode),
                  suggestionsCallback: (query) => List.generate(
                      filter && query == 'one'
                          ? 1
                          : filter && query == 'none'
                              ? 0
                              : count,
                      (index) => index),
                  itemBuilder: (_, item) {
                    onItemBuilt?.call();
                    return SizedBox(
                        height: item.isEven ? 48 : 72,
                        child: Center(child: Text('Option $item')));
                  },
                  onSelected: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ))),
      ]),
    ),
  )));
  await tester.pumpAndSettle();
}
