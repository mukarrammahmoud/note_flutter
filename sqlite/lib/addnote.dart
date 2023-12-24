import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite/method/textFaild.dart';
// import 'package:sqlite/home.dart';
import 'package:sqlite/sqldb.dart';

import 'home.dart';
import 'method/snacbar.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  // String? ti, no;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFaild(hint: "Title", note: note, title: title),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFaild(hint: "Notes", note: note, title: title),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 100,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          color: Colors.amber,
                          onPressed: () async {
                            if (formstate.currentState!.validate()) {
                              int response = await sqldb.insertData(
                                  '''insert into Notes  (title,note,fav,date)
                            values ("${title.text}","${note.text}",$i,"${DateFormat().format(DateTime.now())}")
                            ''');
                              if (response > 0) {
                                title.text = "";
                                note.text = "";
                                Navigator.of(context)
                                    .pushReplacementNamed("home");

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar("Add Successfuly"));
                              }

                              print(response);
                            } else {
                              // print("++++++++++++++++++ response");
                            }
                          },
                          child: const Row(
                            children: [Icon(Icons.done), Text("Add ")],
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
