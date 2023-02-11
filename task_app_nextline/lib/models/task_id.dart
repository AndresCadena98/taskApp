class Task {
  int? id;
  String? title;
  int? iscompleted;
  String? duedate;
  String? comments;
  String? description;
  String? tags;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task({this.id, this.title,this.iscompleted,this.duedate,this.comments,this.description,this.tags,this.token,this.createdAt,this.updatedAt});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        iscompleted: json['is_completed'] ?? 0,
        duedate: json['due_date']?? '',
         comments: json['comments']?? '',
        description: json['description']?? '',
        tags: json['tags'],
        token: json['token'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']
        );
  }
}
