class Tasks {
  int? id;
  String? title;
  int? iscompleted;
  String? duedate;

  Tasks({this.id, this.title,this.iscompleted,this.duedate});

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
        id: json['id'],
        title: json['title'],
        iscompleted: json['is_completed'],
        duedate: json['due_date'],
       
        );
  }
}
