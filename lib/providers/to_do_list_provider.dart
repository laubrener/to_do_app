import 'package:flutter/material.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/services/to_do_service.dart';

class ToDoListProvider extends ChangeNotifier {
  List<ToDo> toDoList = [];
  List<ToDo> defaultList = [];
  List<ToDo> qrTodoList = [];
  ToDoService service = ToDoService();

  bool _isLoading = true;
  bool _isQR = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isQR => _isQR;
  set isQR(bool value) {
    _isQR = value;
    notifyListeners();
  }

  getToDoList() async {
    _isLoading = true;
    toDoList = await service.getToDoList();

    _isLoading = false;
    notifyListeners();
  }

  defaultToDoList() async {
    _isLoading = true;
    defaultList = await service.getDefaultList();
    Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    _isQR = false;
    notifyListeners();
  }

  getQrList(String qrList) async {
    _isLoading = true;
    qrTodoList = await service.getQrList(qrList);
    _isLoading = false;
    _isQR = true;
    notifyListeners();
  }

  addToDo(
      String title, String startTime, String endTime, String? detail) async {
    ToDo newToDo = await service.postToDo(title, startTime, endTime, detail);
    toDoList.add(newToDo);

    _isLoading = false;
    notifyListeners();
  }

  editToDoCheck(ToDo tarea) async {
    await service.editToDoCheck(tarea);
    getToDoList();

    _isLoading = false;
    notifyListeners();
  }

  editToDo(ToDo tarea) async {
    await service.editToDo(tarea);
    getToDoList();

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
