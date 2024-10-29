import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:reto/models/to_do_model.dart';
import 'package:reto/providers/toDoListProvider.dart';
import 'package:reto/pages/form_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  void _loadList() async {
    await toDoListProvider.getList();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _exportToExcel(List<ToDo> list) async {
    // Crear un libro de Excel
    var excel = Excel.createExcel(); // Crear un nuevo libro
    Sheet sheet = excel['Sheet1'];

    // Agregar datos
    sheet.appendRow(
        [TextCellValue('Horario'), TextCellValue('Tarea a realizar')]);
    for (var i = 0; i < list.length; i++) {
      sheet.appendRow([
        TextCellValue('${list[i].start} - ${list[i].end}'),
        TextCellValue(list[i].title)
      ]);
    }
    // sheet!.setColumnWidth(2, 50);
    // sheet.setColumnAutoFit(3);

    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
    //     TextCellValue(time);
    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4)).value =
    //     TextCellValue(title);

// Obtener el directorio de Descargas
    Directory downloadsDirectory = Directory('/storage/emulated/0/Download');
    String path = p.join(downloadsDirectory.path, 'to_do_list.xlsx');

    final file = File(path);
    await file.writeAsBytes(excel.encode()!);
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    // List<ToDo> list = toDoListProvider.toDoList;
    List<ToDo> list = context.watch<ToDoListProvider>().getList();

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Text('LB'),
          ),
        ),
        title: const Text('Formulario de Tareas'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#3D8BEF', 'Cancelar', false, ScanMode.QR);
                print(barcodeScanRes);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             const ScannerPage()));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const FormPage()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // persistentFooterButtons: [
      //   MaterialButton(
      //     padding: const EdgeInsets.all(15),
      //     onPressed: () {},
      //     elevation: 6,
      //     highlightElevation: 5,
      //     shape: const CircleBorder(),
      //     color: Colors.blue,
      //     child: const Icon(
      //       Icons.qr_code_rounded,
      //       color: Colors.white,
      //     ),
      //   ),
      // ],
      body: Stack(
        children: [
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            itemCount: list.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 15),
              // height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      list[index].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink.shade100),
                    child: Text('${list[index].start} - ${list[index].end} hs'),
                  ),
                ],
              ),
            ),
          ),
          if (list.length == 0) Center(child: const Text('No tienes tareas')),
        ],
      ),
    );
  }
}
