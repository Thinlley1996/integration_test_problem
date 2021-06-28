import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// If you want to run the integration test with prod config, you need to have this import to `../lib/main_prod.dart`
import '../lib/main.dart' as app;

// How to run?
// flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d 63B1E047-86E5-462C-9B49-16E6FD9F131D

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Currently, we can't setup intergration tests, because there is a issue with integraiton test package +
  // localization.
  //
  // See this ticket for information: https://github.com/flutter/flutter/issues/84053
  testWidgets('full app test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.pump();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
