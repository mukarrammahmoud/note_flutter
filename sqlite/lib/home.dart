import 'package:flutter/material.dart';

import 'package:sqlite/editNote.dart';
import 'package:sqlite/fav.dart';
import 'package:sqlite/sqldb.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

int i = 0;

class _PageHomeState extends State<PageHome> {
  List color = [
    const Color(0xffD9E76C),
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.brown[300],
    Colors.blueGrey[300],
    Colors.lightGreen,
  ];
  int select = 0;
  bool isloading = true;
  SqlDb sqldb = SqlDb();
  List notes = [];
  List notes2 = [];
  Color col = Colors.white;
  Color col2 = Colors.black;
  Future readdata() async {
    List<Map> respone = await sqldb.readData("select * from Notes");
    notes.addAll(respone);
    isloading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future readdata2() async {
    List<Map> respone = await sqldb.readData("select * from Notes where fav=1");
    notes2.addAll(respone);
    isloading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readdata();
    readdata2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                select = value;
                notes = [];
                readdata();
              });
            },
            currentIndex: select,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: "Favorite"),
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Notes"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed("search");
                // showSearch(context: context, delegate: CustomSearch());
              },
              child: const Icon(Icons.search),
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            child: ListWheelScrollView(itemExtent: 3, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await sqldb.mydeletDataBase();
                          setState(() {});
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.delete),
                            Text("   Delete DataBase"),
                          ],
                        ))
                  ],
                ),
              )
            ]),
          ),
        ),
        body: select == 0
            ? notes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You Don't Have Notes Now !!"),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.hourglass_empty_rounded,
                          size: 42,
                          color: Colors.amber,
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: notes.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return EditNotes(
                                  id: notes[index]["id"],
                                  title: notes[index]["title"],
                                  note: notes[index]["note"],
                                );
                              },
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: color[index % color.length],
                                borderRadius: BorderRadius.circular(14)),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.only(
                                top: 24, bottom: 24, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        "${notes[index]["title"]}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text("${notes[index]["note"]}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              dialogDelete(context, index);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        customMaterialButton(index, context),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${notes[index]["date"]}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
            : Favorite(
                color: color,
                notes2: notes2,
              )
        //
        );
  }

  Future<dynamic> dialogDelete(BuildContext context, int index) {
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
                      setState(() {});
                    }

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PageHome(),
                    ));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  MaterialButton customMaterialButton(int index, BuildContext context) {
    return MaterialButton(
      child: notes[index]["fav"] == 0
          ? const Icon(Icons.star, color: Colors.white)
          : const Icon(Icons.star, color: Colors.black),
      onPressed: () {
        setState(() {
          if (notes[index]["fav"] == 0) {
            col = Colors.black;

            sqldb.updateData('''
                                       update Notes set title= "${notes[index]["title"]}",

                                             note= "${notes[index]["note"]}",
                                             fav=1
                                             where id= ${notes[index]["id"]}
                                       ''');

            setState(() {});
            readdata2();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PageHome(),
            ));
          } else {
            col2 = Colors.white;

            sqldb.updateData('''
                                       update Notes set title= "${notes[index]["title"]}",

                                            note= "${notes[index]["note"]}",
                                             fav=0
                                             where id=${notes[index]["id"]}
                                       ''');

            setState(() {});

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PageHome(),
            ));
          }
        });
      },
    );
  }
}
