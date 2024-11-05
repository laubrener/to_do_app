import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto/models/to_do_model.dart';
import 'package:reto/providers/to_do_list_provider.dart';

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({
    super.key,
    required this.list,
  });

  final List<ToDo> list;

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          bool isChecked = widget.list[index].isChecked!;
          return Row(
            children: [
              Container(
                child: IconButton(
                    onPressed: () {
                      isChecked = !isChecked;
                      print(isChecked);
                      setState(() {});
                    },
                    icon: isChecked
                        ? Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.greenAccent.shade700,
                            size: 28,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            size: 28,
                          )),
              ),
              Expanded(
                child: ToDoWidget(
                  list: widget.list,
                  index: index,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            'Estas seguro que deseas eliminar la tarea: "${widget.list[index].title}"',
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Eliminar'),
                              onPressed: () {
                                context
                                    .read<ToDoListProvider>()
                                    .deleteToDo(widget.list[index].uid!);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                  size: 28,
                ),
              )
            ],
          );
        });
  }
}

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({
    super.key,
    required this.list,
    required this.index,
  });

  final List<ToDo> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 15),
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
              list[index].title ?? '',
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
                color: Colors.greenAccent.shade100),
            child: Text('${list[index].start} - ${list[index].end} hs'),
          ),
        ],
      ),
    );
  }
}
