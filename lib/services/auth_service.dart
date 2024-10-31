import 'dart:convert';

import 'package:http/http.dart';
import 'package:reto/global/environment.dart';
import 'package:reto/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User>? login(String name, String password) async {
    final data = {
      'nombre': name,
      'password': password,
    };

    Uri url = Uri.parse('${Environment.apiUrl}/login');
    Response resp = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });
    UserModel userModel = UserModel.fromRawJson(resp.body);
    User user = userModel.usuario ?? User();
    return user;
  }
}
