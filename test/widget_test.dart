import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aisha/main.dart';

void main() {
  testWidgets('home screen shows the two main actions', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    expect(find.text('VoteSphere'), findsOneWidget);
    expect(find.text('Create a Vote Poll'), findsNWidgets(2));
    expect(find.text('Participate'), findsNWidgets(2));
    expect(find.text('Creator Dashboard'), findsNothing);
  });

  testWidgets('create poll form starts with two candidates', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    await tester.tap(find.widgetWithText(FilledButton, 'Create a Vote Poll'));
    await tester.pumpAndSettle();

    expect(find.text('Create your poll'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Candidate 1'), findsOneWidget);
    expect(find.text('Candidate 2'), findsOneWidget);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -500));
    await tester.pump();
    final addCandidate = find.byIcon(Icons.add);
    expect(addCandidate, findsOneWidget);
    await tester.ensureVisible(addCandidate);
    await tester.tap(addCandidate);
    await tester.pump();
    expect(find.text('Candidate 3'), findsOneWidget);
  });

  testWidgets('participate screen validates an unknown room code', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    await tester.tap(find.widgetWithText(FilledButton, 'Participate'));
    await tester.pumpAndSettle();

    expect(find.text('Join a poll'), findsOneWidget);
    expect(find.text('Room code'), findsOneWidget);
    expect(find.text('Join Poll'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '000000');
    await tester.tap(find.text('Join Poll'));
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('No poll found with that room code.'), findsOneWidget);
  });
}
