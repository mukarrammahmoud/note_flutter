

import 'package:flutter/material.dart';
import 'package:sqlite/sqldb.dart';

import 'editNote.dart';
import 'method/textStyle.dart';

class CustomSearchNotes extends StatefulWidget {
  const CustomSearchNotes({super.key});

  @override
  State<CustomSearchNotes> createState() => _CustomSearchNotesState();
}

class _CustomSearchNotesState extends State<CustomSearchNotes> {
  String? query;
  Future readdata() async {
    noteSearch = [];
    List<Map> respone = await sqldb.readData(
        "select * from Notes where note || title like '%${searchText.text}%'");

    noteSearch.addAll(respone);
    print("========$noteSearch");
  }

  SqlDb sqldb = SqlDb();
  List noteSearch = [];
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              searchText.text = "";
              noteSearch = [];
              setState(() {});
            },
            icon: const Icon(
              Icons.close,
              size: 25,
            )),
        title: TextField(
          onChanged: (value) {
            setState(() {
              query = value;
              readdata();
            });
          },
          cursorColor: Colors.amber,
          controller: searchText,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent)),
            focusColor: Colors.amber,
            hintText: "Search",
            hintStyle: TextStyle(
                color: Colors.tealAccent, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("home");
              },
              icon: const Icon(
                Icons.turn_right,
                size: 25,
              ))
        ],
      ),
      body: noteSearch.isEmpty || searchText.text == ""
          ? Center(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text(
                    "Not Found",
                    style: TextStyle(fontSize: 25),
                  ),
              const    SizedBox(
                    height: 20,
                  ),
                  Transform.rotate(
                    angle: 45,
                    child:const Icon(
                      Icons.warning_rounded,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: noteSearch.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return EditNotes(
                          id: noteSearch[index]["id"],
                          title: noteSearch[index]["title"],
                          note: noteSearch[index]["note"],
                        );
                      },
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(14)),
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    padding:
                        const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          title: Text("${noteSearch[index]["title"]}",
                              style: textStyle(25)),
                          subtitle: Text("${noteSearch[index]["note"]}",
                              style: textStyle(20.0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Text(
                            "${noteSearch[index]["date"]}",
                            style: textStyle(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
