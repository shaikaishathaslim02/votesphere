import 'package:flutter/material.dart';
import '../services/poll_service.dart';
import 'create_poll_screen.dart';
import 'participate_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.service});
  final PollService service;
  @override Widget build(BuildContext context) => ListenableBuilder(listenable: service, builder: (context, _) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900), child: Column(children: [
        const Icon(Icons.how_to_vote_rounded, size: 64, color: Color(0xff3857d6)),
        const SizedBox(height: 12), const Text('VoteSphere', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
        const Text('Simple, fair online polls for colleges and classrooms.', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.black54)),
        const SizedBox(height: 36), LayoutBuilder(builder: (context, box) => Wrap(spacing: 20, runSpacing: 20, alignment: WrapAlignment.center, children: [
          _ChoiceCard(icon: Icons.add_circle_outline, title: 'Create a Vote Poll', text: 'Set up a poll, invite voters, and monitor results.', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreatePollScreen(service: service)))),
          _ChoiceCard(icon: Icons.login_rounded, title: 'Participate', text: 'Join an existing poll with its room code.', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ParticipateScreen(service: service)))),
        ])),
        const SizedBox(height: 32), const Chip(label: Text('LOCAL DEMO MODE • data resets when the app restarts')),
        if (service.latestCreatedPoll != null) ...[
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardScreen(service: service, poll: service.latestCreatedPoll!))),
            icon: const Icon(Icons.dashboard_outlined),
            label: const Text('Open Creator Dashboard'),
          ),
        ],
      ]),
    )))),
  ));
}

class _ChoiceCard extends StatelessWidget { const _ChoiceCard({required this.icon, required this.title, required this.text, required this.onTap}); final IconData icon; final String title, text; final VoidCallback onTap;
  @override Widget build(BuildContext context) => SizedBox(width: 360, child: Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Icon(icon, size: 44, color: const Color(0xff3857d6)), const SizedBox(height: 14), Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)), const SizedBox(height: 18), SizedBox(width: double.infinity, child: FilledButton(onPressed: onTap, child: Text(title)))]))));
}
