import 'package:flutter/material.dart';
import 'package:reto/models/user_model.dart';
import 'package:reto/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _authenticating = false;
  AuthService service = AuthService();
  User? user = User();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  Future<bool> signIn(String name, String password) async {
    authenticating = true;

    try {
      user = await service.login(name, password);
      authenticating = false;
      notifyListeners();
      return true;
    } catch (e) {
      authenticating = false;
      return false;
    }
  }
}
