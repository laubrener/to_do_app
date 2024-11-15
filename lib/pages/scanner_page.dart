import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/providers/to_do_list_provider.dart';
import 'package:reto/widgets/btn_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String qrResult = '';
  ToDoListProvider toDoProvider = ToDoListProvider();

  Future<void> scanQRCode() async {
    final qrProvider = context.read<ToDoListProvider>();
    try {
      String scannedData = await FlutterBarcodeScanner.scanBarcode(
          "#3D8BEF", "Cancelar", true, ScanMode.QR);

      if (scannedData != '-1') {
        setState(() {
          qrResult = scannedData;
        });

        await qrProvider.getQrList(scannedData);
      }
    } catch (e) {
      print('Error al escanear el QR: $e');
    }
  }

  void defaultForm() {
    final provider = context.read<ToDoListProvider>();
    provider.isLoading = true;
    Future.delayed(const Duration(seconds: 2));
    provider.isLoading = false;
    try {
      provider.defaultToDoList();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> qrList = context.watch<ToDoListProvider>().qrTodoList;
    List<ToDo> defaultList = context.watch<ToDoListProvider>().defaultList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nuevo Formulario'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Utilizar'),
                TextButton(
                    onPressed: defaultForm,
                    child: const Text(
                      'Formulario Predeterminado',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent),
                    )),
                const Text('o:'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .27),
            width: double.infinity,
            color: Colors.white,
            child: BtnWidget(
              onPressed: scanQRCode,
              title: 'Escanear QR',
              color: Colors.greenAccent.shade200,
              textColor: Colors.black,
            ),
          ),
          context.watch<ToDoListProvider>().isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              : Expanded(
                  child: FormWidget(
                  list: context.watch<ToDoListProvider>().isQR
                      ? qrList
                      : defaultList,
                )),
          BtnWidget(
              title: 'Agregar tareas',
              onPressed: () {
                // falta hacer funcion para agregar las tareas nuevas
              }),
        ],
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  final List<ToDo> list;
  const FormWidget({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  '${list[index].title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  list[index].detail ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: Text('${list[index].start} - ${list[index].end}'),
                tileColor: Colors.grey.shade200,
                leading: const Icon(Icons.date_range_outlined),
                horizontalTitleGap: 10,
                minVerticalPadding: 10,
              );
            },
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.transparent,
                ),
            itemCount: list.length));
  }
}
