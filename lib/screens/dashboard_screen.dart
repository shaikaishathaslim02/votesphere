import 'dart:async';
import 'package:flutter/material.dart';
import '../models/poll.dart';
import '../services/poll_service.dart';
import '../widgets/page_frame.dart';
import 'results_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.service, required this.poll});
  final PollService service;
  final Poll poll;
  @override State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      widget.service.refresh(widget.poll);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final poll = widget.poll;
    final remaining = poll.deadline.difference(DateTime.now());
    final isClosed = remaining.isNegative || poll.status == PollStatus.closed;
    final status = poll.status == PollStatus.published ? 'RESULTS PUBLISHED' : isClosed ? 'CLOSED' : 'OPEN';
    return PageFrame(
      title: 'Creator Dashboard',
      onBack: () => Navigator.pop(context),
      child: ListView(padding: const EdgeInsets.all(24), children: [
        Row(children: [
          const Expanded(child: Text('Poll overview', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
          Chip(label: Text(status), avatar: Icon(isClosed ? Icons.lock_outline : Icons.radio_button_checked, size: 16)),
        ]),
        const SizedBox(height: 6),
        Text(poll.title, style: const TextStyle(fontSize: 18, color: Colors.black54)),
        const SizedBox(height: 20),
        Card(color: const Color(0xffe9edff), child: Padding(padding: const EdgeInsets.all(20), child: Row(children: [
          const Icon(Icons.meeting_room_outlined, size: 36, color: Color(0xff3857d6)),
          const SizedBox(width: 14),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ROOM CODE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Share this code with participants', style: TextStyle(color: Colors.black54))])),
          SelectableText(poll.roomCode, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff3857d6))),
          IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Room code copied'))), icon: const Icon(Icons.copy)),
        ]))),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, box) => Wrap(spacing: 12, runSpacing: 12, children: [
          _MetricCard(label: 'Total votes', value: '${poll.totalVotes}', icon: Icons.how_to_vote_outlined),
          _MetricCard(label: 'Time remaining', value: isClosed ? 'Closed' : '${remaining.inMinutes}m ${remaining.inSeconds % 60}s', icon: Icons.timer_outlined),
          _MetricCard(label: 'Candidates', value: '${poll.candidates.length}', icon: Icons.people_outline),
        ])),
        const SizedBox(height: 24),
        const Text('Live vote polling', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (final candidate in poll.candidates) _candidateProgress(candidate, poll.totalVotes),
        const SizedBox(height: 18),
        FilledButton.icon(onPressed: poll.status == PollStatus.published ? null : () { widget.service.publish(poll); setState(() {}); }, icon: const Icon(Icons.campaign_outlined), label: Text(poll.status == PollStatus.published ? 'Results Published' : 'Publish Results')),
        OutlinedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsScreen(poll: poll))), icon: const Icon(Icons.poll_outlined), label: const Text('View Full Results')),
      ]),
    );
  }

  Widget _candidateProgress(Candidate candidate, int total) {
    final share = total == 0 ? 0.0 : candidate.votes / total;
    return Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(children: [
      Row(children: [Expanded(child: Text(candidate.name, style: const TextStyle(fontWeight: FontWeight.w600))), Text('${candidate.votes} votes  •  ${(share * 100).toStringAsFixed(1)}%')]),
      const SizedBox(height: 8), LinearProgressIndicator(value: share, minHeight: 8, borderRadius: BorderRadius.circular(8)),
    ])));
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value, required this.icon});
  final String label, value; final IconData icon;
  @override Widget build(BuildContext context) => SizedBox(width: 170, child: Card(child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: const Color(0xff3857d6)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: Colors.black54))]))));
}
