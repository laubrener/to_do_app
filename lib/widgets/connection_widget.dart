import 'package:flutter/material.dart';

class ConnectionWidget extends StatelessWidget {
  const ConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 50,
      color: Colors.red.shade300,
      child: const Row(children: [
        Icon(Icons.wifi_off),
        SizedBox(width: 10),
        Text('No hay conexión a internet'),
      ]),
    );
  }
}
