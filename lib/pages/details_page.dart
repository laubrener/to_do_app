import 'package:flutter/material.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/pages/form_page.dart';
import 'package:reto/widgets/to_do_list_widget.dart';

class DetailsPage extends StatelessWidget {
  final ToDo todo;
  const DetailsPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            todo.title ?? 'Detalle',
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   alignment: Alignment.bottomLeft,
            //   child: Text(
            //     todo.title ?? 'title',
            //     overflow: TextOverflow.ellipsis,
            //     maxLines: 2,
            //     style: const TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),

                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: Colors.greenAccent.shade100),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Text(
                            todo.isChecked ?? false
                                ? 'Tarea Completada'
                                : 'Tarea Incompleta',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent.shade100),
                          child: Text('${todo.start} - ${todo.end} hs'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  if (todo.detail != null)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: Text(
                        todo.detail ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red.shade100),
                        child: DeleteBtn(
                          todo: todo,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue.shade100),
                          child: IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FormPage(todo: todo))),
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ))),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
