import 'package:flutter/material.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/services/to_do_service.dart';

class ToDoListProvider extends ChangeNotifier {
  List<ToDo> toDoList = [];
  ToDoService service = ToDoService();

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getToDoList() async {
    _isLoading = true;
    toDoList = await service.getToDoList();

    _isLoading = false;
    notifyListeners();
  }

  addToDo(String title, String startTime, String endTime) async {
    ToDo newToDo = await service.postToDo(title, startTime, endTime);
    toDoList.add(newToDo);

    _isLoading = false;
    notifyListeners();
  }

  deleteToDo(String id) async {
    bool ok = await service.deleteToDo(id);
    if (ok) {
      toDoList.removeWhere((item) => item.uid == id);
    }

    _isLoading = false;
    notifyListeners();
  }
}
