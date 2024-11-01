import 'package:flutter/material.dart';
import 'package:reto/models/to_do_model.dart';

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({
    super.key,
    required this.list,
  });

  final List<ToDo> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
      ),
    );
  }
}
