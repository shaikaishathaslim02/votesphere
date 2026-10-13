import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:aisha/main.dart';

void main() {
  testWidgets('VoteSphere home screen shows main options', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    expect(find.text('VoteSphere'), findsOneWidget);
    expect(find.text('Modern polling for college communities.'), findsOneWidget);
    expect(find.text('Create a Vote Poll'), findsOneWidget);
    expect(find.text('Participate'), findsOneWidget);
    expect(find.text('Creator Dashboard'), findsNothing);
  });

  testWidgets('Create poll screen renders form fields', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    final createFinder = find.text('Create a Vote Poll').first;
    await tester.ensureVisible(createFinder);
    await tester.tap(createFinder);
    await tester.pumpAndSettle();

    expect(find.text('Create a Vote Poll'), findsOneWidget);
    expect(find.text('Poll title'), findsOneWidget);
    expect(find.text('Poll description'), findsOneWidget);
    expect(find.text('Voting time limit (minutes)'), findsOneWidget);
    expect(find.text('Add Candidate'), findsOneWidget);
    expect(find.text('Generate Poll'), findsOneWidget);
  });

  testWidgets('Participate screen shows room code input', (tester) async {
    await tester.pumpWidget(const VoteSphereApp());

    final participateFinder = find.text('Participate').first;
    await tester.ensureVisible(participateFinder);
    await tester.tap(participateFinder);
    await tester.pumpAndSettle();

    expect(find.text('Join a poll'), findsOneWidget);
    expect(find.text('Room code'), findsOneWidget);
    expect(find.text('Join Poll'), findsOneWidget);
  });

  testWidgets('created poll QR code joins and accepts a vote', (tester) async {
    String? createdRoomCode;
    addTearDown(() {
      if (createdRoomCode != null) {
        demoPolls.remove(createdRoomCode);
        if (mostRecentlyCreatedPollCode == createdRoomCode) {
          mostRecentlyCreatedPollCode = null;
        }
      }
    });

    await tester.pumpWidget(const VoteSphereApp());
    await tester.ensureVisible(find.text('Create a Vote Poll').first);
    await tester.tap(find.text('Create a Vote Poll').first);
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.ensureVisible(fields.at(0));
    await tester.enterText(fields.at(0), 'New candidate poll');
    await tester.ensureVisible(fields.at(1));
    await tester.enterText(fields.at(1), 'Choose the next class representative.');
    await tester.ensureVisible(fields.at(3));
    await tester.enterText(fields.at(3), 'creator-pass-123');
    await tester.ensureVisible(fields.at(4));
    await tester.enterText(fields.at(4), 'Candidate One');
    await tester.ensureVisible(fields.at(5));
    await tester.enterText(fields.at(5), 'Candidate Two');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Generate Poll'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Generate Poll'));
    await tester.pumpAndSettle();

    createdRoomCode = tester
        .widget<Text>(find.byKey(const ValueKey('generated-room-code')))
        .data!;
    final qrCode = tester.widget<QrImageView>(find.byType(QrImageView));
    expect(createdRoomCode, hasLength(6));
    expect(qrCode.errorCorrectionLevel, QrErrorCorrectLevel.H);
    expect(qrCode.size, 256);
    expect(qrCode.semanticsLabel, 'QR code for room $createdRoomCode');
    expect(find.text('Open Creator Dashboard'), findsOneWidget);
    final participationLink = tester
        .widget<SelectableText>(find.byType(SelectableText))
        .data!;
    expect(Uri.parse(participationLink).queryParameters['room'], createdRoomCode);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Participate').first);
    await tester.tap(find.text('Participate').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), createdRoomCode);
    await tester.tap(find.text('Join Poll'));
    await tester.pumpAndSettle();

    expect(find.text('New candidate poll'), findsOneWidget);
    expect(find.text('Candidate One'), findsNWidgets(2));
    final candidateTile = find.widgetWithText(
      RadioListTile<String>,
      'Candidate One',
    );
    await tester.ensureVisible(candidateTile);
    await tester.tap(candidateTile);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Submit Vote'));
    await tester.tap(find.text('Submit Vote'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Submit Vote'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('already voted'), findsOneWidget);
    expect(find.text('1 votes'), findsOneWidget);
  });

  testWidgets('creator dashboard rejects wrong password and opens matching poll', (tester) async {
    const roomCode = 'SECURE1';
    demoPolls[roomCode] = {
      'title': 'Password protected poll',
      'description': 'Dashboard access test.',
      'status': 'Open',
      'candidates': ['Candidate A', 'Candidate B'],
      'votes': {'Candidate A': 3, 'Candidate B': 1},
      'votedParticipants': <String>[],
      'creatorPassword': 'correct-horse-42',
    };
    addTearDown(() => demoPolls.remove(roomCode));

    await tester.pumpWidget(
      const MaterialApp(home: CreatorAccessScreen()),
    );
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), roomCode);
    await tester.enterText(fields.at(1), 'wrong-password');
    await tester.tap(find.text('Unlock dashboard'));
    await tester.pumpAndSettle();

    expect(find.text('Room code or creator password is incorrect.'), findsOneWidget);
    expect(find.text('Password protected poll'), findsNothing);

    await tester.enterText(fields.at(1), 'correct-horse-42');
    await tester.tap(find.text('Unlock dashboard'));
    await tester.pumpAndSettle();

    expect(find.text('Password protected poll'), findsOneWidget);
    expect(find.text('Room code: $roomCode'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });
}
