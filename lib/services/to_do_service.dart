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

  Future<List<ToDo>> getDefaultList() async {
    ToDos toDosModel = ToDos.fromRawJson(generateSampleJSON());
    List<ToDo> toDos = toDosModel.response ?? [];
    return toDos;
  }

  Future<List<ToDo>> getQrList(String qrList) async {
    ToDos toDosModel = ToDos.fromRawJson(qrList);
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

  Future<ToDo> postToDo(
      String title, String start, String end, String? detail) async {
    Uri url = Uri.parse('${Environment.apiUrl}/tareas/new');
    final body = {
      'nombre': title,
      'comienza': start,
      'termina': end,
      'detalle': detail,
    };
    Response resp = await http.post(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    NewTodo toDo = NewTodo.fromRawJson(resp.body);
    ToDo newToDo = toDo.toDo ?? ToDo();
    return newToDo;
  }

  Future<ToDo> editToDo(ToDo tarea) async {
    bool newCheck = !(tarea.isChecked!);
    print(newCheck);
    Uri url = Uri.parse('${Environment.apiUrl}/tareas/${tarea.uid}');
    final body = {
      'isChecked': newCheck,
      'nombre': tarea.title,
      'comienza': tarea.start,
      'termina': tarea.end,
    };
    Response resp = await http.put(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    NewTodo toDo = NewTodo.fromRawJson(resp.body);
    ToDo newToDo = toDo.toDo ?? ToDo();
    return newToDo;
  }

  String generateSampleJSON() {
    Map<String, dynamic> jsonToDoList = {
      "response": [
        {
          'nombre': 'Daily',
          'comienza': '09',
          'termina': '09:15',
          'isChecked': false
        },
        {
          'nombre': 'Tarea de hoy',
          'detalle': 'Desarrollo del nuevo feature',
          'comienza': '09:30',
          'termina': '12:45',
          'isChecked': false
        },
        {
          'nombre': 'Meeting',
          'comienza': '17',
          'termina': '18',
          'isChecked': false
        },
      ]
    };

    String jsonString = jsonEncode(jsonToDoList);
    print(jsonString);
    return jsonString;
  }
}
