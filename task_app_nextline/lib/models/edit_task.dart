// To parse this JSON data, do
//
//     final editTask = editTaskFromJson(jsonString);

import 'dart:convert';

EditTask editTaskFromJson(String str) => EditTask.fromJson(json.decode(str));

String editTaskToJson(EditTask data) => json.encode(data.toJson());

class EditTask {
    EditTask({
        required this.detail,
        required this.task,
    });

    String detail;
    Task task;

    factory EditTask.fromJson(Map<String, dynamic> json) => EditTask(
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
        required this.id,
        required this.title,
        required this.isCompleted,
        required this.dueDate,
        required this.comments,
        required this.description,
        required this.tags,
        required this.token,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String title;
    int isCompleted;
    DateTime dueDate;
    String comments;
    String description;
    String tags;
    String token;
    DateTime createdAt;
    DateTime updatedAt;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        isCompleted: json["is_completed"],
        dueDate: DateTime.parse(json["due_date"]),
        comments: json["comments"],
        description: json["description"],
        tags: json["tags"],
        token: json["token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": token,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
