class TodoListModel {
  final String id;
  final String title;
  final String? description;
  final bool isDone;
  final DateTime createdAt;

  TodoListModel({
    String? id,
    required this.title,
    this.description,
    this.isDone = false,
    DateTime? createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now();
}
