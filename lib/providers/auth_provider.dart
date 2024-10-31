import 'package:flutter/material.dart';
import 'package:reto/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _authenticating = false;
  AuthService service = AuthService();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  Future<bool> signIn(String user, String password) async {
    authenticating = true;

    try {
      await service.login(user, password);
      authenticating = false;
      notifyListeners();
      return true;
    } catch (e) {
      authenticating = false;
      return false;
    }
  }
}
