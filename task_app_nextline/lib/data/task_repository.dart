import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_app_nextline/models/delete_task.dart';
import 'package:task_app_nextline/models/edit_task.dart'as edit;
import 'package:task_app_nextline/models/task_id.dart';
import 'package:task_app_nextline/models/taskadd_model.dart' as add;
import 'package:task_app_nextline/models/tasks_model.dart';

class TasksRepository {
  //Obtener todos los Task
  Future<List<Tasks>?> getTask() async {
    String token =
        'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
          'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks',
          queryParameters: {'token': token});

      List<dynamic> jsonList = json.decode(jsonEncode(response.data));

      // Mapea la lista de objetos a una lista de objetos personalizados
      List<Tasks>? taskList =
          jsonList.map((json) => Tasks.fromJson(json)).toList();
      return taskList;
    } catch (e) {
      print(e);
    }
  }

  // Obtener los datos del task por  ID
  Future<List<Task>?> getTaskByID(int? id) async {
    String token =
        'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
          'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id',
          queryParameters: {'token': token});

      List<dynamic> jsonList = json.decode(jsonEncode(response.data));
      List<Task>? taskList =
          jsonList.map((json) => Task.fromJson(json)).toList();
      print(taskList);
      return taskList;
    } catch (e) {
      print(e);
    }
  }

  //Eliminar Task por ID
  Future deleteTaskByID(int? id) async {
    String token =
        'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.delete(
          'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id',
          queryParameters: {'task_id': id, 'token': token});
      var taskDelete = DeleteTask.fromJson(response.data);

      return taskDelete.detail;
    } catch (e) {
      print(e);
    }
  }

  Future addTask(String? title, int? iscompleted, String duedate,
      String? comments, String? description, String? tags) async {
    String token =
        'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.post(
          'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks',
          data: {
            'token': token,
            'title': title,
            'is_completed': iscompleted,
            'due_date': duedate,
            'comments': comments,
            'description': description,
            'tags': tags,
          });

      var taskAdd = add.TaskAdd.fromJson(response.data);
      return taskAdd.detail;
    } catch (e) {
      print(e);
    }
  }
   Future editTask(int id,String? title, int? iscompleted, String duedate,
      String? comments, String? description, String? tags) async {
    String token =
        'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.put(
          'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks/$id',
          data: {
            'token': token,
            'title': title,
            'is_completed': iscompleted,
            'due_date': duedate,
            'comments': comments,
            'description': description,
            'tags': tags,
          });

    var taskAdd = edit.EditTask.fromJson(response.data);
      return taskAdd.detail;
    } catch (e) {
      print(e);
    }
  }
}
