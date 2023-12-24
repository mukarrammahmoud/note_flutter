// import 'package:flutter/material.dart';

// import 'package:sqlite/sqldb.dart';

// import 'editNote.dart';
// import 'method/deletedialog.dart';

// class ShowData extends StatefulWidget {
//   final notes;
//   final color;
//   const ShowData({super.key, required this.notes, required this.color});

//   @override
//   State<ShowData> createState() => _ShowDataState();
// }

// class _ShowDataState extends State<ShowData> {
//   SqlDb sqldb = SqlDb();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ListView.builder(
//         itemCount: widget.notes.length,
//         // physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) {
//                   return EditNotes(
//                     id: widget.notes[index]["id"],
//                     title: widget.notes[index]["title"],
//                     note: widget.notes[index]["note"],
//                   );
//                 },
//               ));
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: widget.color[index % widget.color.length],
//                   borderRadius: BorderRadius.circular(14)),
//               margin: const EdgeInsets.symmetric(vertical: 6),
//               padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   ListTile(
//                       title: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Text(
//                           "${widget.notes[index]["title"]}",
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Text("${widget.notes[index]["note"]}",
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 dialogDelete(widget.notes);
//                               },
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               )),
                              
//                         ],
//                       )),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("${widget.notes[index]["date"]}",
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15)),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
