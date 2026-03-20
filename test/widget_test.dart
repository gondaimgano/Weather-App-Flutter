import 'package:dvt_weather_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('settings page renders static options',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Forecast up to 5 or 10 records'), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsPage(),
    );
  }
}
