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
      String title, String? detail, String start, String end) async {
    Uri url = Uri.parse('${Environment.apiUrl}/tareas/new');
    final body = {
      'nombre': title,
      'detalle': detail,
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
          'nombre': 'Lavarme los dientes',
          'comienza': '9',
          'termina': '9:05',
          'isChecked': false
        },
        {
          'nombre': 'Desayunar',
          'comienza': '9:30',
          'termina': '9:45',
          'isChecked': false
        },
        {
          'nombre': 'Arreglar la ducha',
          'comienza': '9:45',
          'termina': '11',
          'isChecked': false
        },
        {
          'nombre': 'Ir al gimnasio',
          'detalle': 'Hacer 50 abdominales y 50 sentadillas',
          'comienza': '15:30',
          'termina': '17',
          'isChecked': false
        },
        {
          'nombre': 'Cocinar',
          'comienza': '18',
          'termina': '19',
          'isChecked': false
        },
        {
          'nombre': 'Tomarme una ducha',
          'comienza': '20',
          'termina': '20:30',
          'isChecked': false
        },
        {
          'nombre': 'Estudiar',
          'detalle': 'Estudiar Flutter',
          'comienza': '20:30',
          'termina': '23:30',
          'isChecked': false
        },
        {
          'nombre': 'Dormir',
          'comienza': '23:30',
          'termina': '8',
          'isChecked': false
        }
      ]
    };

    String jsonString = jsonEncode(jsonToDoList);
    print(jsonString);
    return jsonString;
  }
}
