import 'package:flutter/material.dart';
import 'package:front_leilaorv/screens/home.dart';

void main() {
  runApp(const leilaoApp());
}

class leilaoApp extends StatelessWidget {
  const leilaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Leilão Rio Verde",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const leilaoHome(),
    );
  }
}
