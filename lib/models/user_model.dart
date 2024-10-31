import 'dart:convert';

class UserModel {
  final bool? ok;
  final String? msg;
  final User? usuario;
  final String? token;

  UserModel({
    this.ok,
    this.msg,
    this.usuario,
    this.token,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        ok: json["ok"],
        msg: json["msg"],
        usuario:
            json["usuario"] == null ? null : User.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "usuario": usuario?.toJson(),
        "token": token,
      };
}

class User {
  final String? nombre;
  final String? email;
  final String? uid;

  User({
    this.nombre,
    this.email,
    this.uid,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "uid": uid,
      };
}
