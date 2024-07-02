class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };

  static TodoItem fromJson(Map<String, dynamic> json) => TodoItem(
        title: json['title'],
        isCompleted: json['isCompleted'],
      );
}
