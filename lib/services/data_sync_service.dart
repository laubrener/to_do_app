import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

enum ConnectionStatus {
  onLine,
  offLine,
}

class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();

  final _controller = BehaviorSubject.seeded(ConnectionStatus.onLine);
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    _checkConnectivity();
  }

  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??
        _connectivity.onConnectivityChanged.listen((_) {
          _checkConnectivity();
        });
    return _controller.stream;
  }

  Future<void> _checkConnectivity() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(ConnectionStatus.onLine);
        // syncTasks();
      } else {
        _controller.sink.add(ConnectionStatus.offLine);
        // storeDataLocally(data);
      }
    } on SocketException catch (_) {
      _controller.sink.add(ConnectionStatus.offLine);
    }
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    _controller.cast();
  }

  // void storeDataLocally(dynamic data) async {
  //   var box = await Hive.openBox('offlineData');
  //   await box.add(data);
  // }

  // Future<List> getLocalData() async {
  //   var box = await Hive.openBox('offlineData');
  //   print(box.values.toList());
  //   return box.values.toList();
  // }
}
