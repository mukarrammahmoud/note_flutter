import 'package:flutter/material.dart';
import 'package:sqlite/sqldb.dart';

SqlDb sqldb = SqlDb();
Future<Widget>? dialogdelete(List notes) {
  Future<dynamic> dialogDelete(BuildContext context, int index) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          iconColor: Colors.redAccent,
          backgroundColor: Colors.white.withOpacity(0.9),
          contentTextStyle: const TextStyle(color: Colors.black),
          title: const Text(
            "Deletting !",
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(Icons.warning),
          content: const Text("Do You Want Delete This Note ?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.done,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    int respones = await sqldb.deleteData(
                        "delete from notes where id=${notes[index]["id"]}");
                    if (respones > 0) {
                      notes.removeWhere(
                          (element) => element["id"] == notes[index]["id"]);
                      // setState(() {});
                    }
                    Navigator.of(context).pushReplacementNamed("home");
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  return null;


}
