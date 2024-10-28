import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/pages/form_page.dart';
import 'package:reto/providers/toDoListProvider.dart';
import 'package:open_file/open_file.dart';

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

  Future<void> _exportToExcel(String time, String title) async {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];

    sheet!.setColumnWidth(2, 50);
    sheet.setColumnAutoFit(3);

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
        TextCellValue(time);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4)).value =
        TextCellValue(title);

    List<int>? fileBytes = excel.save();
    Directory directory = await getApplicationDocumentsDirectory();

    final String fileName = "${directory.path}/to_do_list.xlsx";
    File(fileName)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    print(fileName);
    OpenFile.open(fileName);
  }

  @override
  Widget build(BuildContext context) {
    // List<ToDo> list = toDoListProvider.toDoList;
    List<ToDo> list = context.watch<ToDoListProvider>().getList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Tareas'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _exportToExcel(
                  '${list.first.start} - ${list.first.end}', list.first.title),
              icon: const Icon(Icons.download))
        ],
      ),
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
                      style: TextStyle(
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
          Positioned(
            bottom: 50,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const FormPage()));
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
