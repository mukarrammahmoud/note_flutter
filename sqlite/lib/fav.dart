import 'package:flutter/material.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:sqlite/sqldb.dart';

import 'editNote.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key, required this.notes2, required this.color});
  final notes2;
  final color;
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  SqlDb sqldb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: widget.notes2.length,
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return EditNotes(
                    id: widget.notes2[index]["id"],
                    title: widget.notes2[index]["title"],
                    note: widget.notes2[index]["note"],
                  );
                },
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.color[index % widget.color.length],
                  borderRadius: BorderRadius.circular(14)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                ListTile(
                    title: Text("${widget.notes2[index]["title"]}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("${widget.notes2[index]["note"]}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              int respones =
                                  await sqldb.deleteData('''update Notes set 
                                               title= "${widget.notes2[index]["title"]}",

                                               note= "${widget.notes2[index]["note"]}",
                                               fav=0
                                               where id= ${widget.notes2[index]["id"]}
                                               ''');
                              if (respones > 0) {
                                widget.notes2.removeWhere((element) =>
                                    element["id"] ==
                                    widget.notes2[index]["id"]);
                                MotionToast(
                                  toastDuration: Duration(seconds: 1),
                                  position: MotionToastPosition.center,
                                  primaryColor:
                                      Color.fromARGB(249, 247, 246, 241),
                                  secondaryColor:
                                      Color.fromARGB(255, 250, 254, 6),
                                  icon: Icons.done_outline,
                                  title: Text("The Favorite"),
                                  description:
                                      Text("The Note Deleted from Favorite!"),
                                  width: 300,
                                  height: 100,
                                ).show(context);

                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.notes2[index]["date"]}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
