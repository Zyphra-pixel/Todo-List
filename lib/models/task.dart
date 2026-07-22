class Task {
  String title;
  bool isChecked;

  Task({required this.title, required this.isChecked});

  Map<String, dynamic> toJson() {
    return {'title': title, 'isChecked': isChecked};
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(title: json['title'], isChecked: json['isChecked']);
  }
}
