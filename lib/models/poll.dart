enum PollStatus { open, closed, published }

class Candidate {
  Candidate({required this.id, required this.name, this.votes = 0});
  final String id;
  final String name;
  int votes;
}

class Poll {
  Poll({required this.id, required this.title, required this.description, required this.roomCode, required this.creatorId, required this.deadline, required this.candidates});
  final String id;
  final String title;
  final String description;
  final String roomCode;
  final String creatorId;
  final DateTime deadline;
  final List<Candidate> candidates;
  PollStatus status = PollStatus.open;
  final Set<String> voters = {};
  bool get isClosed => DateTime.now().isAfter(deadline) || status != PollStatus.open;
  int get totalVotes => candidates.fold(0, (sum, c) => sum + c.votes);
}
