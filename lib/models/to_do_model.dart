import 'dart:convert';

class ToDos {
  final bool? ok;
  final List<ToDo>? response;

  ToDos({
    this.ok,
    this.response,
  });

  factory ToDos.fromRawJson(String str) => ToDos.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToDos.fromJson(Map<String, dynamic> json) => ToDos(
        ok: json["ok"],
        response: json["response"] == null
            ? []
            : List<ToDo>.from(json["response"]!.map((x) => ToDo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class ToDo {
  final String? title;
  final String? start;
  final String? end;
  final bool? isChecked;
  final String? uid;

  ToDo({
    this.title,
    this.start,
    this.end,
    this.isChecked,
    this.uid,
  });

  factory ToDo.fromRawJson(String str) => ToDo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        title: json["nombre"],
        start: json["comienza"],
        end: json["termina"],
        isChecked: json["isChecked"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": title,
        "comienza": start,
        "termina": end,
        "isChecked": isChecked,
        "uid": uid,
      };
}

class NewTodo {
  final bool? ok;
  final String? msg;
  final ToDo? toDo;

  NewTodo({
    this.ok,
    this.msg,
    this.toDo,
  });

  factory NewTodo.fromRawJson(String str) => NewTodo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewTodo.fromJson(Map<String, dynamic> json) => NewTodo(
        ok: json["ok"],
        msg: json["msg"],
        toDo: json["toDo"] == null ? null : ToDo.fromJson(json["toDo"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "toDo": toDo?.toJson(),
      };
}
