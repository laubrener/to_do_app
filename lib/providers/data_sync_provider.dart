import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:reto/main.dart';
import 'package:reto/providers/toDoListProvider.dart';
import 'package:reto/services/data_sync_service.dart';
import 'package:reto/services/to_do_service.dart';

class ConnectionStatusProvider extends ChangeNotifier {
  late StreamSubscription _connectionSubscription;
  ToDoService service = ToDoService();
  ToDoListProvider provider = ToDoListProvider();

  ConnectionStatus status = ConnectionStatus.onLine;

  ConnectionStatusProvider() {
    _connectionSubscription =
        internetChecker.internetStatus().listen((newStatus) {
      status = newStatus;
      if (status == ConnectionStatus.onLine) {
        syncTasks();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  void storeTaskLocally(Map<String, dynamic> task) async {
    // Guarda la tarea en una base de datos local
    var box = await Hive.openBox('offlineTasks');
    // await box.add(task);
    await box.put(box.values.toList().length, task);
    print(box.values);
  }

  void syncTasks() async {
    var box = await Hive.openBox('offlineTasks');
    List tasks = box.values.toList();

    if (tasks != [] || tasks.isEmpty) {
      for (int i = 0; i < tasks.length; i++) {
        await provider.addToDo(tasks[i]['nombre'], tasks[i]['comienza'],
            tasks[i]['termina']); // Llama al método del Provider
        box.delete(
            i); // Elimina del almacenamiento local si se envió exitosamente
      }
      // for (var task in tasks) {
      //   await provider.addToDo(task['nombre'], task['comienza'],
      //       task['termina']); // Llama al método del Provider

      //   box.delete(
      //       task.); // Elimina del almacenamiento local si se envió exitosamente
      // }
    }
  }
}
