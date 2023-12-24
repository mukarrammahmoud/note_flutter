import 'package:flutter/material.dart';
import 'package:sqlite/method/textFaild.dart';
import 'package:sqlite/sqldb.dart';

import 'method/snacbar.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, this.title, this.note, this.id});

  final title;

  final note;
  final id;
  @override
  State<EditNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<EditNotes> {
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;

    title.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFaild(hint: "Title", note: note, title: title),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextFaild(hint: "Notes", note: note, title: title),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 100,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          color: Colors.amber,
                          onPressed: () async {
                            int response = await sqldb.updateData('''
                              update Notes set
                               title="${title.text}",
                              note="${note.text}"
                             
                              where id =${widget.id}
                            ''');
                            if (response > 0) {
                              Navigator.of(context)
                                  .pushReplacementNamed("home");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar("Edit Successfuliy"));
                            }

                            print(
                                response); // print("++++++++++++++++++ response");
                          },
                          child: const Row(
                            children: [Icon(Icons.done), Text("Edit ")],
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
