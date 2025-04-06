import 'package:flutter/material.dart';
import 'package:front_leilaorv/screens/Home_fetchApi.dart';

void main() {
  runApp(const leilaoApp());
}

class leilaoApp extends StatelessWidget {
  const leilaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Leilão Rio Verde",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const leilaoHome(),
    );
  }
}
