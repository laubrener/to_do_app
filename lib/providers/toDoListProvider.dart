import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:reto/models/to_do_model.dart';

class ToDoListProvider extends ChangeNotifier {
  List<ToDo> toDoList = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ToDo> getList() {
    return toDoList;
  }

  addToDo(String title, String startTime, String endTime) async {
    toDoList.add(ToDo(title: title, start: startTime, end: endTime));

    _isLoading = false;
    notifyListeners();
  }
}
