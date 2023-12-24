import 'package:flutter/material.dart';

class MyTextFaild extends StatefulWidget {
  const MyTextFaild(
      {super.key, required this.hint, required this.note, required this.title});
  final String hint;
  final TextEditingController note;
  final TextEditingController title;
  @override
  State<MyTextFaild> createState() => _MyTextFaildState();
}

class _MyTextFaildState extends State<MyTextFaild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "ٌالحقل فارغ";
        }
        return null;
      },
      cursorColor: Colors.amber,
      maxLines: widget.hint == "Notes" ? 7 : 3,
      controller: widget.hint == "Notes" ? widget.note : widget.title,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: widget.hint == "Notes" ? "Notes" : "Title",
        labelStyle: const TextStyle(color: Colors.amber, fontSize: 20),
        focusedBorder: borderOutline(Colors.amber),
        enabledBorder: borderOutline(Colors.blueAccent),
        hintText: widget.hint == "Notes" ? "Notes" : "Title",
      ),
    );
  }

  OutlineInputBorder borderOutline(Color color) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: color, width: 2));
  }
}
