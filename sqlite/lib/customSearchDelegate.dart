import 'package:flutter/material.dart';
import 'package:sqlite/sqldb.dart';

class CustomSearch extends SearchDelegate {
  SqlDb sqldb = SqlDb();
  List sugg = [];
  String q = "";
  // Future readdata() async {
  //   List<Map> respone =
  //       await sqldb.readData("select * from Notes where title  like '$q%'");
  //   sugg.addAll(respone);
  //   return sugg;
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      MaterialButton(
        onPressed: () {},
        child: IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
              close(context, null);
            },
            icon: const Icon(Icons.arrow_back)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = "";
          sugg = [];
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return Text("data");
    Future readdata() async {
      List<Map> respone = await sqldb
          .readData("select * from Notes where  title like '%$query%'");
      sugg = [];

      sugg.addAll(respone);
      // print("========$sugg");
      return sugg;
    }

    print(sugg);
    readdata();
    // print(sugg.length);
    return ListView.builder(
      itemCount: sugg.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(14)),
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text("${sugg[index]["title"]}"),
                subtitle: Text("${sugg[index]["note"]}"),
              ),
            ],
          ),
        );
      },
    );
  }
}
