

import 'dart:convert';

TaskAdd taskAddFromJson(String str) => TaskAdd.fromJson(json.decode(str));

String taskAddToJson(TaskAdd data) => json.encode(data.toJson());

class TaskAdd {
    TaskAdd({
        required this.detail,
        required this.task,
    });

    String detail;
    Task task;

    factory TaskAdd.fromJson(Map<String, dynamic> json) => TaskAdd(
        detail: json["detail"],
        task: Task.fromJson(json["task"]),
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
        "task": task.toJson(),
    };
}

class Task {
    Task({
        required this.title,
        required this.isCompleted,
        required this.dueDate,
        required this.comments,
        required this.description,
        required this.tags,
        required this.token,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    String title;
    int isCompleted;
    DateTime dueDate;
    String comments;
    String description;
    String tags;
    String token;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        isCompleted: json["is_completed"],
        dueDate: DateTime.parse(json["due_date"]),
        comments: json["comments"],
        description: json["description"],
        tags: json["tags"],
        token: json["token"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "is_completed": isCompleted,
        "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": token,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
