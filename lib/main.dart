import 'package:flutter/material.dart';
import '../pages/home.dart';

main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    title: "News Reader Apps",
    theme: ThemeData(fontFamily: "Poppins"),
  ));
}
