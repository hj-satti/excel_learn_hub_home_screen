import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:excel_learn_hub/main.dart';

void main() {
  testWidgets('Search filters courses correctly', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(MyApp());

    // Let everything render
    await tester.pumpAndSettle();

    // Type 'Python' into the search bar
    await tester.enterText(find.byType(TextField), 'Python');
    await tester.pumpAndSettle();

    // Now check if:
    // - Only Python course is visible
    expect(find.text('Python'), findsWidgets); // It's okay if more than one (e.g. title + input field)
    expect(find.text('Flutter'), findsNothing); // Make sure Flutter is NOT shown

    // Optional: Check only 1 course card is showing
    final courseCards = find.byType(Card);
    expect(courseCards, findsOneWidget);
  });
}