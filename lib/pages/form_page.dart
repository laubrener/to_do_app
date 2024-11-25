import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto/pages/home_page.dart';
import 'package:reto/providers/data_sync_provider.dart';
import 'package:reto/providers/to_do_list_provider.dart';
import 'package:reto/services/data_sync_service.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Tarea'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: const _Form()),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final titleCtrl = TextEditingController();
  final startCtrl = TextEditingController();
  final endCtrl = TextEditingController();
  final detailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConnectionStatusProvider connectionProvider =
        context.watch<ConnectionStatusProvider>();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: titleCtrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Escriba la Tarea',
              labelText: 'Tarea',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: detailCtrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Detalle la Tarea',
              labelText: 'Detalle',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: startCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Escriba a que hora comienza',
              labelText: 'Comienza',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: endCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              hintText: 'Escriba a que hora termina',
              labelText: 'Termina',
            ),
          ),
        ),
        const SizedBox(height: 10),
        MaterialButton(
          onPressed: () {
            print('${startCtrl.text} - ${endCtrl.text}: ${titleCtrl.text}');
            if (connectionProvider.status == ConnectionStatus.onLine) {
              context.read<ToDoListProvider>().addToDo(titleCtrl.text,
                  startCtrl.text, endCtrl.text, detailCtrl.text);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            } else {
              connectionProvider.storeTaskLocally({
                'nombre': titleCtrl.text,
                'comienza': startCtrl.text,
                'termina': endCtrl.text,
                'detalle': detailCtrl.text
              });
              Navigator.pop(context);
            }
          },
          elevation: 2,
          highlightElevation: 5,
          shape: const StadiumBorder(),
          color: Colors.deepPurpleAccent,
          child: Container(
            width: double.infinity,
            height: 50,
            child: const Center(
              child: Text(
                'Guardar',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
