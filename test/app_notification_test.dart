import 'package:app/common/widgets/toast.dart';
import 'package:app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    AppNotification.dismiss();
    Global.navigatorKey = GlobalKey<NavigatorState>();
    Global.rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  });

  Future<void> pumpNotificationHost(
    WidgetTester tester, {
    bool accessibleNavigation = false,
    bool disableAnimations = false,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        navigatorKey: Global.navigatorKey,
        scaffoldMessengerKey: Global.rootScaffoldMessengerKey,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            accessibleNavigation: accessibleNavigation,
            disableAnimations: disableAnimations,
          ),
          child: child!,
        ),
        home: const SizedBox.expand(),
      ),
    );
  }

  Future<void> finishEntranceAnimation(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('toastInfo works without a Scaffold and can be dismissed', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);

    await toastInfo(msg: 'Check your connection');
    await finishEntranceAnimation(tester);

    expect(find.text('Check your connection'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);

    final dismissible = tester.widget<Dismissible>(find.byType(Dismissible));
    expect(dismissible.direction, DismissDirection.horizontal);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Check your connection'), findsNothing);
  });

  testWidgets('info notifications remain visible before auto-dismissal', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);

    AppNotification.show(message: 'Saved for later');
    await finishEntranceAnimation(tester);
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Saved for later'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Saved for later'), findsNothing);
  });

  testWidgets('error notifications use the error style and longer duration', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);

    AppNotification.show(
      message: 'Unable to sync',
      type: AppNotificationType.error,
    );
    await finishEntranceAnimation(tester);

    expect(find.text('Unable to sync'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Unable to sync'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('a synchronous notification replaces the pending notification', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);

    AppNotification.show(message: 'First message');
    AppNotification.show(message: 'Latest message');
    await finishEntranceAnimation(tester);

    expect(find.text('First message'), findsNothing);
    expect(find.text('Latest message'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('replacement during dismissal does not remove the new message', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);

    AppNotification.show(message: 'Closing message');
    await finishEntranceAnimation(tester);
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump(const Duration(milliseconds: 100));

    AppNotification.show(message: 'Replacement message');
    await finishEntranceAnimation(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Closing message'), findsNothing);
    expect(find.text('Replacement message'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('notification actions run and dismiss the notification', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);
    var actionCalled = false;

    AppNotification.show(
      message: 'Unable to connect',
      type: AppNotificationType.error,
      actionLabel: 'Retry',
      onAction: () => actionCalled = true,
    );
    await finishEntranceAnimation(tester);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(actionCalled, isTrue);
    expect(find.text('Unable to connect'), findsNothing);
  });

  testWidgets('an action still runs when its notification is replaced', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);
    var actionCalls = 0;

    AppNotification.show(
      message: 'Try the request again',
      actionLabel: 'Retry',
      onAction: () => actionCalls += 1,
    );
    await finishEntranceAnimation(tester);

    await tester.tap(find.text('Retry'));
    await tester.pump(const Duration(milliseconds: 100));
    AppNotification.show(message: 'Request restarted');
    await finishEntranceAnimation(tester);

    expect(actionCalls, 1);
    expect(tester.takeException(), isNull);
    expect(find.text('Request restarted'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('rapid action taps invoke the callback only once', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(tester);
    var actionCalls = 0;

    AppNotification.show(
      message: 'Retry the request',
      actionLabel: 'Retry',
      onAction: () => actionCalls += 1,
    );
    await finishEntranceAnimation(tester);

    await tester.tap(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(actionCalls, 1);
    expect(find.text('Retry the request'), findsNothing);
  });

  testWidgets('accessible actionable notifications do not auto-dismiss', (
    WidgetTester tester,
  ) async {
    await pumpNotificationHost(
      tester,
      accessibleNavigation: true,
      disableAnimations: true,
    );

    AppNotification.show(
      message: 'Connection interrupted',
      duration: const Duration(milliseconds: 100),
      actionLabel: 'Retry',
      onAction: () {},
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('Connection interrupted'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    expect(find.text('Connection interrupted'), findsNothing);
  });

  testWidgets('a notification retries once when the navigator mounts', (
    WidgetTester tester,
  ) async {
    AppNotification.show(message: 'Queued message');

    await pumpNotificationHost(tester);
    await finishEntranceAnimation(tester);

    expect(find.text('Queued message'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('showing before the navigator is attached is safe', (
    WidgetTester tester,
  ) async {
    expect(
      () => AppNotification.show(message: 'Not attached yet'),
      returnsNormally,
    );
    await tester.pump();
  });
}
