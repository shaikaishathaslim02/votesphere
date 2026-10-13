import 'dart:async';
import 'package:flutter/material.dart';
import '../models/poll.dart';
import '../services/poll_service.dart';
import '../widgets/page_frame.dart';
import 'results_screen.dart';

class ParticipantDashboardScreen extends StatefulWidget {
  const ParticipantDashboardScreen({super.key, required this.service, required this.poll});
  final PollService service;
  final Poll poll;
  @override State<ParticipantDashboardScreen> createState() => _ParticipantDashboardState();
}

class _ParticipantDashboardState extends State<ParticipantDashboardScreen> {
  Timer? timer;
  @override void initState() { super.initState(); timer = Timer.periodic(const Duration(seconds: 1), (_) { widget.service.refresh(widget.poll); if (mounted) setState(() {}); }); }
  @override void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final poll = widget.poll;
    final remaining = poll.deadline.difference(DateTime.now());
    final published = poll.status == PollStatus.published;
    return PageFrame(title: 'Your Voting Dashboard', onBack: () => Navigator.pop(context), child: ListView(padding: const EdgeInsets.all(24), children: [
      const Icon(Icons.check_circle_outline, color: Colors.green, size: 58),
      const SizedBox(height: 12),
      const Text('Your vote was submitted', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('Thank you for participating. Your ballot is recorded for this poll.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 24),
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(poll.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _row(Icons.meeting_room_outlined, 'Room code', poll.roomCode),
        _row(Icons.lock_outline, 'Your ballot', 'Submitted'),
        _row(Icons.timer_outlined, 'Poll status', published ? 'Results published' : remaining.isNegative ? 'Closed' : 'Voting is open'),
      ]))),
      const SizedBox(height: 18),
      if (!published) const Card(color: Color(0xffeef1ff), child: Padding(padding: EdgeInsets.all(16), child: Text('Results are hidden until the poll creator publishes them.', textAlign: TextAlign.center))),
      if (published) FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsScreen(poll: poll))), icon: const Icon(Icons.poll_outlined), label: const Text('See Published Results')),
    ]));
  }

  Widget _row(IconData icon, String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 13), child: Row(children: [Icon(icon, size: 19, color: const Color(0xff3857d6)), const SizedBox(width: 10), Expanded(child: Text(label)), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))]));
}
