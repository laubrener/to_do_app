import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:reto/models/to_do_model.dart';
import 'package:reto/pages/scanner_page.dart';
import 'package:reto/providers/data_sync_provider.dart';
import 'package:reto/providers/to_do_list_provider.dart';
import 'package:reto/pages/form_page.dart';
import 'package:reto/services/data_sync_service.dart';
import 'package:reto/widgets/bottom_widget.dart';
import 'package:reto/widgets/connection_widget.dart';
import 'package:reto/widgets/to_do_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ToDoListProvider toDoListProvider = ToDoListProvider();

  @override
  void initState() {
    toDoListProvider = context.read<ToDoListProvider>();
    _loadList();

    super.initState();
  }

  Future<void> _loadList() async {
    await toDoListProvider.getToDoList();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _exportToExcel(List<ToDo> list) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    sheet.appendRow(
        [TextCellValue('Horario'), TextCellValue('Tarea a realizar')]);
    for (var i = 0; i < list.length; i++) {
      sheet.appendRow([
        TextCellValue('${list[i].start} - ${list[i].end}'),
        TextCellValue(list[i].title!)
      ]);
    }
    Directory downloadsDirectory = Directory('/storage/emulated/0/Download');
    String path = p.join(downloadsDirectory.path, 'to_do_list.xlsx');

    final file = File(path);
    await file.writeAsBytes(excel.encode()!);
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> list = context.watch<ToDoListProvider>().toDoList;

    ConnectionStatusProvider connectionProvider =
        context.watch<ConnectionStatusProvider>();
    double finishedToDos() {
      int done = 0;
      for (int i = 0; i < list.length; i++) {
        if (list[i].isChecked == true) {
          done++;
        }
      }
      double percentage = (done / list.length);
      return percentage;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Text(
              (widget.name[0] + widget.name[1]).toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        title: const Text('Lista de Actividades'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const ScannerPage()

                        // GenerateQRScreen()
                        ));
              },
              icon: const Icon(Icons.qr_code_sharp)),
          IconButton(
              onPressed: () {
                if (list.length == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Agregá una tarea para descargar'),
                  ));
                } else {
                  _exportToExcel(list);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Descargando excel a la carpeta de descargas'),
                  ));
                }
              },
              icon: const Icon(Icons.download)),
        ],
      ),
      bottomSheet: BottomWidget(percent: finishedToDos()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const FormPage()));
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _loadList,
            child: ToDoListWidget(list: list),
          ),
          if (list.length == 0) const Center(child: Text('No tienes tareas')),
          if (connectionProvider.status != ConnectionStatus.onLine)
            const ConnectionWidget(),
        ],
      ),
    );
  }
}
