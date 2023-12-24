import 'package:flutter/material.dart';

// import 'package:path/path.dart';

SnackBar customSnackBar(String msg) {
  return SnackBar(
      showCloseIcon: true,
      backgroundColor: Colors.amber,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ));
}
