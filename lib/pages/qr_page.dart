import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRScreen extends StatelessWidget {
  final String jsonString = '''
  {
    "response": [
      {
        "nombre": "Tarea 1",
        "comienza": "08:00",
        "termina": "09:00",
        "isChecked": false
      },
      {
        "nombre": "Tarea 2",
        "comienza": "09:30",
        "termina": "10:30",
        "isChecked": false
      },
      {
        "nombre": "Tarea 3",
        "comienza": "11:00",
        "termina": "12:00",
        "isChecked": false
      }
    ]
  }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generar QR')),
      body: Center(
        child: QrImageView(
          data: jsonString,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
