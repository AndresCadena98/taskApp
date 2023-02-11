
import 'dart:convert';

DeleteTask deleteTaskFromJson(String str) => DeleteTask.fromJson(json.decode(str));

String deleteTaskToJson(DeleteTask data) => json.encode(data.toJson());

class DeleteTask {
    DeleteTask({
        required this.detail,
    });

    String detail;

    factory DeleteTask.fromJson(Map<String, dynamic> json) => DeleteTask(
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
    };
}
