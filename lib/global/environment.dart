import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.0.167:3000/api'
      : 'http://localhost:3000/api';
}
