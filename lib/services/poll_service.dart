import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/poll.dart';

class PollService extends ChangeNotifier {
  final Map<String, Poll> _polls = {};
  final Set<String> _remotePolls = {};
  Poll? _latestCreatedPoll;
  final String participantId = 'demo-browser-participant';
  Poll? get latestCreatedPoll => _latestCreatedPoll;

  Uri _url(String path) => Uri.parse('${const String.fromEnvironment('API_BASE_URL', defaultValue: '')}${const String.fromEnvironment('API_BASE_URL', defaultValue: '').isEmpty ? Uri.base.origin : ''}/api$path');

  Poll _fromJson(Map<String, dynamic> json, {String creatorId = ''}) {
    final poll = Poll(id: json['id'].toString(), title: json['title'], description: json['description'], roomCode: json['roomCode'], creatorId: creatorId, deadline: DateTime.parse(json['deadline']), candidates: [for (final c in json['candidates']) Candidate(id: c['id'], name: c['name'], votes: c['votes'] ?? 0)]);
    poll.status = PollStatus.values.firstWhere((s) => s.name == json['status'], orElse: () => PollStatus.open);
    return poll;
  }

  Future<Poll> createPoll({required String title, required String description, required int minutes, required List<String> names}) async {
    try {
      final response = await http.post(_url(''), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'title': title, 'description': description, 'minutes': minutes, 'candidates': names}));
      if (response.statusCode == 201) { final body = jsonDecode(response.body); final poll = _fromJson(body['poll'], creatorId: body['creatorId']); _remotePolls.add(poll.id); _polls[poll.roomCode] = poll; _latestCreatedPoll = poll; notifyListeners(); return poll; }
    } catch (_) {}
    final code = (100000 + Random().nextInt(900000)).toString();
    final poll = Poll(
      id: DateTime.now().microsecondsSinceEpoch.toString(), title: title, description: description,
      roomCode: code, creatorId: 'demo-creator', deadline: DateTime.now().add(Duration(minutes: minutes)),
      candidates: [for (var i = 0; i < names.length; i++) Candidate(id: 'c$i', name: names[i])],
    );
    _polls[code] = poll; _latestCreatedPoll = poll; notifyListeners(); return poll;
  }

  Future<Poll?> find(String code) async {
    final local = _polls[code.trim()]; if (local != null) return local;
    try { final response = await http.get(_url('/${code.trim()}')); if (response.statusCode == 200) { final poll = _fromJson(jsonDecode(response.body)); _remotePolls.add(poll.id); _polls[poll.roomCode] = poll; return poll; } } catch (_) {}
    return null;
  }

  Future<String?> submitVote(Poll poll, String candidateId) async {
    if (_remotePolls.contains(poll.id)) {
      try { final response = await http.post(_url('/${poll.roomCode}/votes'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'candidateId': candidateId, 'voterId': participantId})); if (response.statusCode == 201) { poll.voters.add(participantId); notifyListeners(); return null; } final body = jsonDecode(response.body); return body['error'] ?? 'Vote could not be recorded.'; } catch (_) { return 'Backend is unavailable. Please try again.'; }
    }
    if (poll.isClosed) return 'Voting is closed for this poll.';
    if (poll.voters.contains(participantId)) return 'You have already voted in this poll.';
    final candidate = poll.candidates.where((c) => c.id == candidateId).firstOrNull;
    if (candidate == null) return 'That candidate is not valid.';
    candidate.votes++; poll.voters.add(participantId); notifyListeners(); return null;
  }

  Future<String?> publish(Poll poll) async { if (_remotePolls.contains(poll.id)) { try { final response = await http.post(_url('/${poll.roomCode}/publish'), headers: {'Content-Type': 'application/json', 'x-creator-id': poll.creatorId}, body: jsonEncode({'creatorId': poll.creatorId})); if (response.statusCode != 200) return 'Only the creator can publish results.'; } catch (_) { return 'Backend is unavailable.'; } } poll.status = PollStatus.published; notifyListeners(); return null; }
  Future<void> refresh(Poll poll) async { if (_remotePolls.contains(poll.id)) { try { final response = await http.get(_url('/${poll.roomCode}/dashboard'), headers: {'x-creator-id': poll.creatorId}); if (response.statusCode == 200) { final fresh = _fromJson(jsonDecode(response.body), creatorId: poll.creatorId); poll.status = fresh.status; for (final c in poll.candidates) { final update = fresh.candidates.firstWhere((x) => x.id == c.id, orElse: () => c); c.votes = update.votes; } notifyListeners(); } } catch (_) {} } else if (poll.status == PollStatus.open && poll.isClosed) { poll.status = PollStatus.closed; notifyListeners(); } }
}
