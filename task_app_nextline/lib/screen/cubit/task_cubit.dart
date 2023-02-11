import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app_nextline/data/task_repository.dart';
import 'package:task_app_nextline/models/task_id.dart';
import 'package:task_app_nextline/models/tasks_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState(tasks: [],));
  final _repo = TasksRepository();
  List<Tasks>? tasksFinal = [];
  List<Task>? taskFinal = [];
  void getTask() async {
    var response = await _repo.getTask();

    tasksFinal = response ?? [];
    
    emit(state.copyWith(tasks: tasksFinal));
    
  }
   Future getTaskById(int? id) async {
    var response = await _repo.getTaskByID(id);
    taskFinal = response ?? [];
    emit(state.copyWith(task: response));
    
  }
   Future deleteTaskById(int? id) async {
    var response = await _repo.deleteTaskByID(id);
    
    return response;
    
  }
   Future addTask(String? titulo, int? check,String? checkDate) async {
    var response = await _repo.addTask(titulo,check,checkDate.toString(),'','','');
    return response;
    
  }
  Future editTask(int id,String? titulo, int? check,String? checkDate) async {
    var response = await _repo.editTask(id,titulo,check,checkDate.toString(),'','','');
    return response;
    
  }
}
