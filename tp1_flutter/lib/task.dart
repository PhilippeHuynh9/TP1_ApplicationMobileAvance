class Task {
  String title;
  int progressPercent; // 0..100
  DateTime createdAt;
  DateTime? dueDate;

  Task({
    required this.title,
    this.progressPercent = 0,
    DateTime? createdAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  int percentTimeElapsed() {
    if (dueDate == null) return 0;
    final total = dueDate!.difference(createdAt).inMilliseconds;
    if (total <= 0) return 100;
    final elapsed = DateTime.now().difference(createdAt).inMilliseconds;
    final pct = (elapsed / total * 100).round();
    if (pct < 0) return 0;
    if (pct > 100) return 100;
    return pct;
  }
}

