import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'package:front_leilaorv/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const leilaoApp(),
    ),
  );
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
