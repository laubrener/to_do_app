import 'dart:convert';

import 'package:http/http.dart';
import 'package:reto/global/environment.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:http/http.dart' as http;

class ToDoService {
  Future<List<ToDo>> getToDoList() async {
    Uri url = Uri.parse('${Environment.apiUrl}/tareas');
    Response resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    ToDos toDosModel = ToDos.fromRawJson(resp.body);
    List<ToDo> toDos = toDosModel.response ?? [];
    return toDos;
  }

  Future<bool> deleteToDo(String id) async {
    Uri url = Uri.parse('${Environment.apiUrl}/tareas/$id');
    Response resp = await http.delete(url, headers: {
      'Content-Type': 'application/json',
    });
    ToDos toDosModel = ToDos.fromRawJson(resp.body);

    return toDosModel.ok!;
  }

  Future<ToDo> postToDo(String title, String start, String end) async {
    Uri url = Uri.parse('${Environment.apiUrl}/tareas/new');
    final body = {
      'nombre': title,
      'comienza': start,
      'termina': end,
    };
    Response resp = await http.post(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    NewTodo toDo = NewTodo.fromRawJson(resp.body);
    ToDo newToDo = toDo.toDo ?? ToDo();
    return newToDo;
  }
}
