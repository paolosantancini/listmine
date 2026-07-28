class Task {
  final int id;
  final String title;
  final bool done;

  Task({
    required this.id,
    required this.title,
    required this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      done: json["done"] == 1 || json["done"] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "done": done,
    };
  }

  Task copyWith({
    int? id,
    String? title,
    bool? done,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}
