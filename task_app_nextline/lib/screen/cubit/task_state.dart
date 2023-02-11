part of 'task_cubit.dart';

// ignore: must_be_immutable
class TaskState {
  List<Tasks>? tasks = [];
  List<Task>? task =[];
  String? successAdd = '';
  TaskState({
     this.tasks,
     this.task,
     this.successAdd
  });
  TaskState copyWith({List<Tasks>? tasks,List<Task>? task,String? successAdd}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      task: task ?? this.task,
      successAdd:successAdd ?? this.successAdd
    );
  }

  // ignore: override_on_non_overriding_member
  @override
  List<Object?> get props => [tasks,task,successAdd];

  @override
  String toString() {
    return 'TaskState(task: $tasks,';
  }
}
