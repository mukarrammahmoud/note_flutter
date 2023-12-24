import 'package:flutter/material.dart';
import 'package:sqlite/sqldb.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.notes});
  final List notes;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  SqlDb sqldb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deletting !"),
      icon: const Icon(Icons.warning),
      content: const Text("Do You Want Delete This Note ?"),
      actions: [
        const SizedBox(
          width: 40,
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("home");
          },
        ),
        const SizedBox(
          width: 40,
        ),
        IconButton(
          icon: Icon(Icons.done),
          onPressed: () async {
            int respones = await sqldb
                .deleteData("delete from notes where id=${widget.notes}");
            if (respones > 0) {
              widget.notes.removeWhere(
                  (element) => element["id"] == widget.notes);
              setState(() {});
            }
            Navigator.of(context).pushReplacementNamed("home");
          },
        ),
      ],
    );
  }
}
