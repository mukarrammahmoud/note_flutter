import 'package:flutter/material.dart';
import 'package:sqlite/addnote.dart';
import 'package:sqlite/editNote.dart';
import 'package:sqlite/home.dart';

import 'customSearch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const PageHome(),
      routes: {
        "addnotes": (context) => const AddNotes(),
        "editnotes": (context) => const EditNotes(),
        "home": (context) => const PageHome(),
        "search": (context) => const CustomSearchNotes(),
      },
    );
  }
}
