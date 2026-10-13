import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _forest = Color(0xff183b35);
const _canvas = Color(0xfff3f5ef);
const _muted = Color(0xff6d7873);
const _lime = Color(0xffc8ef74);

class VotingApp extends StatelessWidget {
  const VotingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common Vote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: _forest),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: _forest,
            fontSize: 29,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          titleLarge: TextStyle(
            color: _forest,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(color: _muted, fontSize: 14, height: 1.45),
        ),
      ),
      home: const VotingPage(),
    );
  }
}

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  int _page = 0;
  int? _selectedCandidate;
  bool _hasVoted = false;
  final List<int> _votes = [284, 216, 173];

  static const _candidates = [
    _Candidate(
      name: 'flutter sir',
      platform: 'Community first',
      summary: 'A more connected, welcoming campus.',
      initials: 'MC',
      background: Color(0xffd9e8ce),
      foreground: Color(0xff46734d),
    ),
    _Candidate(
      name: 'chandra sekhar sir',
      platform: 'Ideas into action',
      summary: 'Transparent budgets and better spaces.',
      initials: 'JE',
      background: Color(0xfff4dfcd),
      foreground: Color(0xffa75e37),
    ),
    _Candidate(
      name: 'django sir',
      platform: 'Make room for everyone',
      summary: 'Student voices in every decision.',
      initials: 'SP',
      background: Color(0xffdce4f1),
      foreground: Color(0xff54749a),
    ),
  ];

  int get _totalVotes => _votes.fold(0, (total, count) => total + count);

  Future<void> _submitVote() async {
    final choice = _selectedCandidate;
    if (choice == null || _hasVoted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review your ballot'),
        content: Text(
          'You selected ${_candidates[choice].name}. '
          'After submission, your choice cannot be changed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Go back'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Submit ballot'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _votes[choice]++;
        _hasVoted = true;
      });
    }
  }

  Future<void> _copyVoterId() async {
    await Clipboard.setData(const ClipboardData(text: 'DEMO-2048-0316'));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sample voter ID copied')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _navigationDrawer,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Column(
              children: [
                _header(),
                Expanded(
                  child: _page == 0
                      ? _ballotPage
                      : _page == 1
                      ? _resultsPage
                      : _voterIdPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _navigationDrawer {
    const destinations = [
      (Icons.how_to_vote_outlined, 'Vote'),
      (Icons.poll_outlined, 'Results'),
      (Icons.person_outline, 'Voter ID'),
    ];

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 18),
              child: Text(
                'ELECTION MENU',
                style: TextStyle(
                  color: _muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Divider(height: 1),
            for (var index = 0; index < destinations.length; index++)
              ListTile(
                leading: Icon(destinations[index].$1),
                title: Text(destinations[index].$2),
                selected: _page == index,
                selectedColor: _forest,
                selectedTileColor: const Color(0xffedf4e6),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _page = index);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 20, 10),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              tooltip: 'Open navigation menu',
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
              color: _forest,
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _forest,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.how_to_vote, color: _lime, size: 20),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'common vote',
                style: TextStyle(
                  color: _forest,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'CAMPUS ELECTIONS',
                style: TextStyle(
                  color: _muted,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Open voter ID',
            onPressed: () => setState(() => _page = 2),
            icon: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xffdce8d7),
              child: Text(
                'AT',
                style: TextStyle(
                  color: _forest,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _ballotPage {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _electionBanner,
              const SizedBox(height: 24),
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: _ballotSection),
                    const SizedBox(width: 24),
                    Expanded(flex: 4, child: _electionInfo),
                  ],
                )
              else ...[
                _ballotSection,
                const SizedBox(height: 20),
                _electionInfo,
              ],
            ],
          ),
        );
      },
    );
  }

  Widget get _electionBanner {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _forest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 6,
            top: 0,
            child: Icon(
              Icons.how_to_vote_outlined,
              size: 92,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _lime,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'DEMO ELECTION  ·  POLLS OPEN',
                  style: TextStyle(
                    color: _forest,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your campus.\nYour next chapter.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Student Council Election 2026',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Icon(Icons.schedule, color: _lime, size: 16),
                  SizedBox(width: 7),
                  Text(
                    'Closes October 18 at 8:00 PM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _ballotSection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _hasVoted ? 'Ballot recorded' : 'Choose your candidate',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          _hasVoted
              ? 'Your ballot has been recorded on this device.'
              : 'Select one candidate. Review your choice before submitting.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < _candidates.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _candidateTile(index),
          ),
        if (_selectedCandidate != null && !_hasVoted) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffe9efe3),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: _forest, size: 18),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Selected: ${_candidates[_selectedCandidate!].name}',
                    style: const TextStyle(
                      color: _forest,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _selectedCandidate = null),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton.icon(
            onPressed: !_hasVoted && _selectedCandidate != null
                ? _submitVote
                : null,
            icon: Icon(_hasVoted ? Icons.check_circle : Icons.how_to_vote),
            label: Text(_hasVoted ? 'Vote submitted' : 'Review and submit vote'),
            style: FilledButton.styleFrom(
              backgroundColor: _forest,
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xffdfe4dc),
              disabledForegroundColor: _muted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
        if (_hasVoted) ...[
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Center(
              child: Text(
                'Your vote is in',
                style: TextStyle(
                  color: Color(0xff46734d),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _page = 1),
              icon: const Icon(Icons.poll_outlined),
              label: const Text('View election results'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _candidateTile(int index) {
    final candidate = _candidates[index];
    final selected = _selectedCandidate == index;
    return Semantics(
      button: true,
      selected: selected,
      label: '${candidate.name}, ${candidate.platform}',
      child: InkWell(
        onTap: _hasVoted
            ? null
            : () => setState(() => _selectedCandidate = index),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? const Color(0xffedf4e6) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? _forest : const Color(0xffe2e6df),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: candidate.background,
                child: Text(
                  candidate.initials,
                  style: TextStyle(
                    color: candidate.foreground,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      candidate.platform,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      candidate.summary,
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                selected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selected ? _forest : const Color(0xffb8c0ba),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _electionInfo {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe2e6df)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ELECTION SNAPSHOT',
            style: TextStyle(
              color: _muted,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _infoRow(Icons.people_outline, 'Sample eligible voters', '1,240'),
          const SizedBox(height: 14),
          _infoRow(Icons.how_to_vote_outlined, 'Sample ballots', '$_totalVotes'),
          const SizedBox(height: 14),
          _infoRow(
            Icons.lock_outline,
            'Your ballot',
            _hasVoted ? 'Submitted' : 'Not submitted',
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: (_totalVotes / 1240).clamp(0, 1),
              minHeight: 7,
              backgroundColor: const Color(0xffe9ede6),
              color: const Color(0xff75a66b),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Illustrative turnout',
            style: TextStyle(color: _muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _muted),
        const SizedBox(width: 9),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Text(
          value,
          style: const TextStyle(
            color: _forest,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget get _resultsPage {
    final leader = _votes.indexOf(_votes.reduce((a, b) => a > b ? a : b));
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Election results', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          Text(
            'Sample tally for the Student Council Election.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _forest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.poll, color: _lime, size: 25),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SAMPLE BALLOTS',
                        style: TextStyle(
                          color: Color(0xffc7d3cb),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$_totalVotes',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'DEMO TALLY',
                  style: TextStyle(
                    color: _lime,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('Candidate standings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (var index = 0; index < _candidates.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: _resultTile(index, leader),
            ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: _muted),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Illustrative figures only. This demo does not store or transmit real ballots.',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultTile(int index, int leader) {
    final candidate = _candidates[index];
    final share = _votes[index] / _totalVotes;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe2e6df)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: candidate.background,
                child: Text(
                  candidate.initials,
                  style: TextStyle(
                    color: candidate.foreground,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${_votes[index]} votes',
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                '${(share * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: _forest,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: share,
              minHeight: 8,
              backgroundColor: const Color(0xffe9ede6),
              color: index == leader
                  ? const Color(0xff75a66b)
                  : candidate.foreground,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _voterIdPage {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Voter ID', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          Text(
            'Sample voter record and ballot status.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _forest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: _lime,
                  child: Text(
                    'AT',
                    style: TextStyle(
                      color: _forest,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Sample voter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'DEMO-2048-0316',
                  style: TextStyle(color: Color(0xffc7d3cb), fontSize: 12),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _copyVoterId,
                    style: TextButton.styleFrom(foregroundColor: _lime),
                    icon: const Icon(Icons.copy, size: 16),
                    label: const Text('Copy voter ID'),
                  ),
                ),
                Container(height: 1, color: Colors.white24),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Election ballot',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    Icon(
                      _hasVoted ? Icons.check_circle : Icons.pending_outlined,
                      color: _lime,
                      size: 17,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _hasVoted ? 'Submitted' : 'Not submitted',
                      style: const TextStyle(
                        color: _lime,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffe2e6df)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: _forest),
                SizedBox(width: 11),
                Expanded(
                  child: Text(
                    'Sample details for preview only. Identity verification and secure voting require a connected election service.',
                    style: TextStyle(color: _muted, fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Candidate {
  const _Candidate({
    required this.name,
    required this.platform,
    required this.summary,
    required this.initials,
    required this.background,
    required this.foreground,
  });

  final String name;
  final String platform;
  final String summary;
  final String initials;
  final Color background;
  final Color foreground;
}
